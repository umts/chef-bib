repo_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
chef_repo_path repo_root
cookbook_path [File.join(repo_root, 'vendor-cookbooks'),
               File.join(repo_root, 'cookbooks')]
log_level :info
