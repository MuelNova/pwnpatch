#!/usr/bin/env fish

# 定义获取 libc 目录的函数
function __fish_pwnpatch_get_libc_dirs
    set -l libc_dirs /usr/share/glibc-all-in-one/libs/
    for d in (ls $libc_dirs)
        if test -d $libc_dirs/$d
            echo $d
        end
    end
end

# 定义获取 patchelf 选项的函数
function __fish_pwnpatch_get_patchelf_opts
    echo '--remove-needed'
    echo '--add-needed'
    echo '--replace-needed'
    # 可以添加更多 patchelf 选项
end

# 为 -l 选项定义补全
complete -c pwnpatch -n "not __fish_contains_opt -s l" -f -a "-l" -d "Select a libc library"
complete -c pwnpatch -s l -d 'Select a libc library'
complete -c pwnpatch -s p -d 'Append pwnpatch options'
complete -c pwnpatch -s h -l help -d 'Show help text'
complete -c pwnpatch -n "__fish_contains_opt -s l" -F -d "Attachment"
complete -c pwnpatch -r -f -s l -a '(__fish_pwnpatch_get_libc_dirs)'
complete -c pwnpatch -r -f -s p -a '(__fish_pwnpatch_get_patchelf_opts)'
