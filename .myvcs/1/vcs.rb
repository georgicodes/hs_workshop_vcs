require 'fileutils'

def init_vcs_base_dir(current_dir)
  arr =  current_dir.split("/")
  #arr = arr.take(arr.length - 1)
  vcs_file_path = arr.join("/") + "/.myvcs"

  create_dir_if_not_exists(vcs_file_path)

  return vcs_file_path
end

def create_dir_if_not_exists(path_name)
  if (!File.exists?(path_name))
    Dir.mkdir(path_name)
  end
end

def get_next_version_num(vcs_path)
  dirs = Dir.entries(vcs_path)
  puts "#{dirs}"

  highest_version = 0
  dirs.each do |dir|
    if (dir.to_i > highest_version)
      highest_version = dir.to_i
    end
  end
  return highest_version += 1
end

def copy_current_dir
  current_dir = File.expand_path(File.dirname(__FILE__))
  base_vcs_path = init_vcs_base_dir(current_dir)
  version_num = get_next_version_num(base_vcs_path)
  vcs_file_path = base_vcs_path + "/" + version_num.to_s
  create_dir_if_not_exists(vcs_file_path)
  puts "Copy from: #{current_dir}"
  puts "Copy too: vcs_file_path"

  FileUtils.cp_r(Dir[current_dir + '/*'], vcs_file_path)
end

copy_current_dir()