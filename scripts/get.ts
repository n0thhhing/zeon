import fs from "fs";

function getAllMatches(
  regex: RegExp,
  input: string,
  onlyGroups: boolean = false
): string[] {
  const matches: string[] = [];
  let match;

  while ((match = regex.exec(input)) !== null) {
    if (onlyGroups) {
      if (match.length > 1) {
        matches.push(match[1]);
      }
    } else {
      matches.push(match[0]);
    }
  }

  return matches;
}

function readFile(filePath: string): string {
  try {
    return fs.readFileSync(filePath, 'utf-8');
  } catch (error) {
    console.error(`Error reading file ${filePath}:`, error);
    return '';
  }
}

const SYM_FILE = __dirname + '/ALL';
const ZIG_FILE = __dirname + '/../src/zeon.zig';

const symContent = readFile(SYM_FILE);
let functionNames = symContent.split('\n').map(fn => fn.trim()).filter(fn => fn);

const implemented: string[] = [];

functionNames.sort();

const allFunctionNames = [...functionNames]

const total = functionNames.length;

// Extract function definitions from the Zig file
const regex = /pub inline fn (\S+)\(/g;
const input = readFile(ZIG_FILE);
const allMatches = getAllMatches(regex, input, true);

// Remove implemented functions from the list
allMatches.forEach(match => {
  const index = functionNames.indexOf(match);
  if (index !== -1) {
    functionNames.splice(index, 1);
  }
});

// Group function names by their base name and type (type is at the end, prefixed with '_')
const groupedFunctions: Record<string, string[]> = {};
allFunctionNames.forEach(fn => {
  const splitFn = /(.*)_(\S+)$/.exec(fn);
  if (splitFn != null) {
      const baseName = splitFn[1]; // base function name
      const type = splitFn[2];     // type at the end

      if (!type) return; // Ignore functions without a type suffix

      if (!groupedFunctions[baseName]) {
        groupedFunctions[baseName] = [];
      }
      groupedFunctions[baseName].push(type);
  }
});

// Find functions with missing types
const incompleteFunctions: Record<string, string[]> = {};
Object.entries(groupedFunctions).forEach(([baseName, types]) => {
  const implementedTypes = allMatches
    .filter(match => new RegExp(baseName + '_(\\S+)$').exec(match) != null)
    .map(match => /(.*)_(\S+)$/.exec(match)?.[2]);
  // If at least one type is implemented but not all, track the missing ones
  if (implementedTypes.length > 0 && implementedTypes.length < types.length) {
    const missingTypes: string[] = types.filter(type => !implementedTypes.includes(type));
    if (missingTypes.length > 0) {
      incompleteFunctions[baseName] = missingTypes;
    }
  }
});

// Write unimplemented functions and log the incomplete ones
fs.writeFileSync(__dirname + "/UNIMPL", functionNames.join("\n"));
console.log({
  implemented_count: allMatches.length,
  unimplemented_count: functionNames.length,
  total_count: total,
  incomplete_functions: incompleteFunctions,
  implemented: allMatches,
  unimplemented: functionNames,
});
