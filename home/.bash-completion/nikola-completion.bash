# bash completion for nikola
# auto-generate by `nikola tabcompletion`

# to activate it you need to 'source' the generate script
# $ source <generated-script>

# reference => http://www.debian-administration.org/articles/317
# patch => http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=711879

_nikola()
{
    local cur prev words cword basetask sub_cmds tasks i dodof
    COMPREPLY=() # contains list of words with suitable completion
    # remove colon from word separator list because doit uses colon on task names
    _get_comp_words_by_ref -n : cur prev words cword
    # list of sub-commands
    sub_cmds="auto bootswatch_theme build check clean console deploy doit_auto dumpdb forget github_deploy help ignore import_wordpress info init install_theme list new_page new_post orphans plugin reset-dep rst2html run serve status strace tabcompletion version"


    # options that take file/dir as values should complete file-system
    if [[ "$prev" == "-f" || "$prev" == "-d" || "$prev" == "-o" ]]; then
        _filedir
        return 0
    fi
    if [[ "$cur" == *=* ]]; then
        prev=${cur/=*/}
        cur=${cur/*=/}
        if [[ "$prev" == "--file=" || "$prev" == "--dir=" || "$prev" == "--output-file=" ]]; then
            _filedir -o nospace
            return 0
        fi
    fi


    # get task list
    # if it there is colon it is getting a subtask, complete only subtask names
    if [[ "$cur" == *:* ]]; then
        # extract base task name (remove everything after colon)
        basetask=${cur%:*}
        # sub-tasks
        tasks=$(nikola list  --quiet --all ${basetask} 2>/dev/null)
        COMPREPLY=( $(compgen -W "${tasks}" -- ${cur}) )
        __ltrim_colon_completions "$cur"
        return 0
    # without colons get only top tasks
    else
        tasks=$(nikola list  --quiet 2>/dev/null)
    fi


    # match for first parameter must be sub-command or task
    # FIXME doit accepts options "-" in the first parameter but we ignore this case
    if [[ ${cword} == 1 ]] ; then
        COMPREPLY=( $(compgen -W "${sub_cmds} ${tasks}" -- ${cur}) )
        return 0
    fi

    case ${words[1]} in

        auto)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        bootswatch_theme)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        build)
            COMPREPLY=( $(compgen -W "${tasks}" -- $cur) )
            return 0
            ;;
        check)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        clean)
            COMPREPLY=( $(compgen -W "${tasks}" -- $cur) )
            return 0
            ;;
        console)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        deploy)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        doit_auto)
            COMPREPLY=( $(compgen -W "${tasks}" -- $cur) )
            return 0
            ;;
        dumpdb)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        forget)
            COMPREPLY=( $(compgen -W "${tasks}" -- $cur) )
            return 0
            ;;
        github_deploy)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        help)
            COMPREPLY=( $(compgen -W "${tasks} ${sub_cmds}" -- $cur) )
            return 0
            ;;
        ignore)
            COMPREPLY=( $(compgen -W "${tasks}" -- $cur) )
            return 0
            ;;
        import_wordpress)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        info)
            COMPREPLY=( $(compgen -W "${tasks}" -- $cur) )
            return 0
            ;;
        init)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        install_theme)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        list)
            COMPREPLY=( $(compgen -W "${tasks}" -- $cur) )
            return 0
            ;;
        new_page)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        new_post)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        orphans)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        plugin)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        reset-dep)
            COMPREPLY=( $(compgen -W "${tasks}" -- $cur) )
            return 0
            ;;
        rst2html)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        run)
            COMPREPLY=( $(compgen -W "${tasks}" -- $cur) )
            return 0
            ;;
        serve)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        status)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        strace)
            COMPREPLY=( $(compgen -W "${tasks}" -- $cur) )
            return 0
            ;;
        tabcompletion)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
        version)
            COMPREPLY=( $(compgen -f -- $cur) )
            return 0
            ;;
    esac

    # if there is already one parameter match only tasks (no commands)
    COMPREPLY=( $(compgen -W "${tasks}" -- ${cur}) )

}
complete -o filenames -F _nikola nikola
