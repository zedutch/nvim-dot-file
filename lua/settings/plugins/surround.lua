local ok, surround = pcall(require, 'nvim-surround')
if not ok then
    print 'Skipping nvim-surround as it is not installed.'
    return
end

surround.setup {}
