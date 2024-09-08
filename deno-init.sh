#!/bin/bash

# プロジェクト名を引数から取得
PROJECT_NAME=${PWD##*/}

echo "現在のディレクトリ '$PROJECT_NAME' にDenoプロジェクトを初期化します。"

# Deno プロジェクトを初期化
deno init

# deno.jsonを編集
cat > deno.json << EOL
{
  "tasks": {
    "start": "deno run main.ts",
    "dev": "deno run --watch main.ts"
  },
  "imports": {
    "/": "./",
    "./": "./src/"
  },
  "compilerOptions": {
    "lib": ["deno.window"]
  }
}
EOL

# srcディレクトリを作成
mkdir -p src

# src/app.tsを作成
cat > src/app.ts << EOL
export function greet(name:string): string {
  return \`Hello, \${name}!\`\;
}
EOL


# main.tsの内容を更新
cat > main.ts << EOL
import { greet } from "./src/app.ts";

function main() {
  console.log(greet("World"));
}

if (import.meta.main) {
  main();
}
EOL

echo "Denoプロジェクト '$PROJECT_NAME' が初期化されました。"
