module.exports = {
  preset: '',
  // Automatically clear mock calls and instances between every test
  clearMocks: true,

  coverageDirectory: 'dist/coverage',

  coveragePathIgnorePatterns: [
    '<rootDir>/node_modules/(?!@foo)',
    '<rootDir>/dist/',
  ],

  globals: {
    'ts-jest': {
      tsconfig: '<rootDir>/tsconfig.json',
    },
  },

  moduleFileExtensions: ['ts', 'js'],

  moduleNameMapper: {
    'config/(.*)': '<rootDir>/src/config/$1',
    'database/(.*)': '<rootDir>/src/database/$1',
    'shared/(.*)': '<rootDir>/src/shared/$1',
    'utilities/(.*)': '<rootDir>/src/utilities/$1',
    'testing/(.*)': '<rootDir>/src/testing/$1',
  },

  testEnvironment: 'node',

  testRegex: '(/tests/.*|(\\.|/)(test|spec))\\.(jsx?|tsx?)$',

  transform: {
    '^.+\\.(ts|tsx)$': 'ts-jest',
  },

  transformIgnorePatterns: ['<rootDir>/node_modules/(?!@foo)'],

  coverageThreshold: {
    global: {
      statements: 85,
      branches: 85,
      functions: 75,
      lines: 80,
    },
  },
};
