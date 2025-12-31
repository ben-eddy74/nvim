nvim --headless "+Lazy! sync" +qa
git commit .\lazy-lock.json -m "Update plugins"
git push
