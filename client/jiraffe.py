import urllib
import os

SERVICE_URL = "http://jiraffe.cloudhub.io/api"
CREATE_SERVICE = SERVICE_URL + "/issues"
DEFAULT_SERVICE = SERVICE_URL + "/defaults"
COMPONENT_SERVICE = SERVICE_URL + "/components"

def get_valid_reporter(reporter):
  if reporter == "":
    return os.environ['JIRA_ID']
  return reporter

def createIssue(project, summary, bug_type, sprint, reporter, assignee, priority, component):
    query_args = {'summary': summary, 'reporter': get_valid_reporter(reporter)}
    headers = {"content-type": "application/plain-text"}

    if project != "":
        query_args['project'] = project

    if bug_type != "":
        query_args['type'] = bug_type

    if sprint != "":
        query_args['sprint'] = sprint

    valid_assignee = get_valid_reporter(assignee)
    if valid_assignee != "":
        query_args['assignee'] = valid_assignee

    if priority != "":
        query_args['priority'] = priority

    encoded_args = urllib.urlencode(query_args)
    #print(encoded_args)
    print(urllib.urlopen(CREATE_SERVICE +"?"+ encoded_args, encoded_args).read())

def update_defaults(project, sprint, bug_type):
    #{"sprint":"123","type":"Bug","project":"AUTOMATION","id":9}
    query_args = {}

    if project != "":
        query_args['project'] = project

    if bug_type != "":
        query_args['type'] = bug_type

    if sprint != "":
        query_args['sprint'] = sprint

    encoded_args = urllib.urlencode(query_args)
    #print(encoded_args)
    headers = {"content-type": "application/plain-text"}
    print(urllib.urlopen(DEFAULT_SERVICE +"?"+ encoded_args, encoded_args).read())

def show_issue(issue_id):
    response = urllib.urlopen(CREATE_SERVICE + "/" + issue_id)
    print(response.read())

def show_components(project_id):
    query_args = {}

    if project_id != "":
        query_args['project'] = project_id

    encoded_args = urllib.urlencode(query_args)
    response = urllib.urlopen(COMPONENT_SERVICE+ "?" + encoded_args)
    print(response.read())

def show_defaults():
    response = urllib.urlopen(DEFAULT_SERVICE)
    print(response.read())
