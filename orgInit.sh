sfdx force:org:create -f config/project-scratch-def.json -s -d 1
sfdx force:source:push
sfdx msm:user:password:set -p __SF18__ -g User -l User --json
sfdx force:org:display --verbose
sfdx force:org:open