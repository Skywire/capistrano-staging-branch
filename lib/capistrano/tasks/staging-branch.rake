namespace :stagingbranch do
  desc "Checks the currently checked out remote git branch matches the branch being deployed"
  task :reserve do
    on release_roles :all do
      within release_path do
        execute "echo \"#{fetch(:branch, "master")}\" > #{release_path}/.branch"
      end
    end
  end
  task :free do
    on release_roles :all do
      within release_path do
        execute "echo master > #{release_path}/.branch"
      end
    end
  end
end

after "deploy:published", "stagingbranch:reserve"
