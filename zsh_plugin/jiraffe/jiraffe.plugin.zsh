# aliases

# completion function
_jiraffe () {
    local -a _1st_arguments _create_dopts _common_dopts
    local expl
    typeset -A opt_args

    _common_dopts=(
	'(-t)-t[Jira issue type]:issue type:(Bug Improvement "New Feature" Impediment Task Story)'
	'(-s)-s[Current sprint number]:sprint number'
	'(-p)-p[Project ID]:project key:(STUDIO MULE AUTOMATION EE APIKIT ION SIT)'
    )

    _create_dopts=(
    	'(-r)-r[Reporter]:jira id:($JIRA_ID)'
	'(-a)-a[Assignee]:jira id:($JIRA_ID)'
	'(-pr)-pr[Issue priority]:priority:(Major Critical Blocker Trivial Minor)'
    )

    _1st_arguments=(
    'create:Create a jira issue and return the issue ID' \
    'show:Show information for a given issue id'\
    'components:Show components for a given project id' \
    'default:Show current default values' \
    'update:Update current default values' \
    'help:Display help' \
    )
     _arguments \
    '*:: :->subcmds' && return 0

    if (( CURRENT == 1 )); then
        _describe -t commands "jiraffe subcommand" _1st_arguments
        return
    fi

    case "$words[1]" in
        create)
	_arguments \
	$_create_dopts \
	$_common_dopts \
        ;;
        update)
	_arguments \
	$_common_dopts \
        ;;
    esac

}

compdef _jiraffe jiraffe
