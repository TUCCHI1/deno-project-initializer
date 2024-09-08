import { greet } from "./src/app.ts"

function main() {
  console.log(greet("World"));
}

if (import.meta.main) {
  main();
}
