local opts = {
  -- 検索時の設定
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  hlsearch = true,
  -- 対応する括弧を表示
  showmatch = true,
  -- バックアップを作らない
  backup = false,
  -- コマンド入力時に表示する
  showcmd = true,
  -- コマンド・メッセージ表示欄を2行確保
  cmdheight = 2,
  -- ステータスラインを常に表示
  laststatus = 2,
  -- スクロール時に10行余白を確保する
  scrolloff = 10,
  -- シンタックスハイライトの有効化
  syntax = "on",
  -- <Tab>でshiftwidthの数だけ<Space>を入力する
  smartindent = true,
  -- マウス操作をすべて受け付ける
  mouse = "a",
  -- utf-8でエンコードする
  encoding = "utf-8",
  fileencodings = "utf-8",
  -- 候補の表示方法の設定
  completeopt = "menu,menuone,noselect",
  wildmenu = true,
  wildmode = "longest,full",
  -- クリップボードを共有化
  clipboard = "unnamed,unnamedplus",
  -- 色設定
  termguicolors = true,
  background = "dark",
  -- HELPを日本語化
  helplang = "ja,en",
  -- UNDOの永続化
  undofile = true,
  -- 編集されたファイルを自動読み込み
  autoread = true,
  wrapscan = true,
}

local win_opts = {
  -- カーソル行を強調
  cursorline = true,
  -- 行数を表示
  number = true,
  -- サイン用ガーターを常に表示
  signcolumn = "yes",
}

local buf_opts = {
  -- utf-8でエンコードする
  fileencoding = "utf-8",
  -- スワップファイルを作らない
  swapfile = false,
  -- <Tab>で<Space>を使用する
  expandtab = true,
  autoindent = true,
  shiftwidth = 2,
  softtabstop = 2,
  spelllang = "en_us",
}

local api = vim.api

for k, v in pairs(opts) do
  api.nvim_set_option(k, v)
end

for k, v in pairs(win_opts) do
  api.nvim_set_option(k, v)
end

for k, v in pairs(buf_opts) do
  api.nvim_set_option(k, v)
end
