local worktree_ok, worktree = pcall(require, "git-worktree")
if not worktree_ok then
  return
end

local default_opts = {
    change_directory_command = "cd",
    update_on_change = true,
    update_on_change_command = "e .",
    clearjumps_on_change = true,
    autopush = false,
}
worktree.setup(default_opts)


-- Hooks
-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted

worktree.on_tree_change(function(op, metadata)
  if op == worktree.Operations.Switch then
  	print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
    vim.cmd ('BufferCloseAllButCurrent')
    vim.cmd ('e')
  end
end)
