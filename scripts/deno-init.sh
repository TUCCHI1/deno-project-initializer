#!/bin/bash

# プロジェクト名を引数から取得
PROJECT_NAME=$1

# プロジェクト名が指定されていない場合はエラーメッセージを表示して終了
if [ -z "$PROJECT_NAME" ]; then
  echo "エラー: プロジェクト名を指定してください。"
  echo "使用方法: ./deno-init.sh <プロジェクト名>"
  exit 1
fi

# プロジェクトディレクトリを作成
mkdir $PROJECT_NAME
cd $PROJECT_NAME

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
  }
}
EOL

# srcディレクトリを作成
mkdir src

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
