nvim --headless "+lua vim.pack.update(nil, { target = 'lockfile' })" +qa
nvim --headless "+MasonUpdate" +qa
nvim --headless "+TSUpdate" +qa

git commit .\nvim-pack-lock.json -m "Update plugins"
git push

