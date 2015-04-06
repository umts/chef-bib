def build_pacman_aur(package_name)
  ChefSpec::Matchers::ResourceMatcher.new(:pacman_aur, :build, package_name)
end

def install_pacman_aur(package_name)
  ChefSpec::Matchers::ResourceMatcher.new(:pacman_aur, :install, package_name)
end
