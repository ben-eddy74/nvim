nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonUpdate" +qa
nvim --headless "+TSUpdate" +qa

git commit .\lazy-lock.json -m "Update plugins"
git push
