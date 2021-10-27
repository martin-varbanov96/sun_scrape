#!/bin/bash

# TODO: this is the output:
# Are you sure you want to make this change? (Y/n)?  y

# ERROR: (gcloud.iam.roles.create) INVALID_ARGUMENT: The number of permissions in the role is greater than the maximum of 3,000.
# [martin@arch scripts]$ gcloud iam roles describe roles/editor | less
# [martin@arch scripts]$ 
# [martin@arch scripts]$ 
# [martin@arch scripts]$ sh create_editor.
# WARNING: API is not enabled for permissions: [eventarc.events.receiveAuditLogWritten, eventarc.locations.get, eventarc.locations.list, eventarc.operations.cancel, eventarc.operations.delete, eventarc.operations.get, eventarc.operations.list, eventarc.triggers.create, eventarc.triggers.delete, eventarc.triggers.get, eventarc.triggers.getIamPolicy, eventarc.triggers.list, eventarc.triggers.setIamPolicy, eventarc.triggers.undelete, eventarc.triggers.update, recommender.locations.get, recommender.locations.list, remotebuildexecution.blobs.get, run.configurations.get, run.configurations.list, run.locations.list, run.revisions.delete, run.revisions.get, run.revisions.list, run.routes.get, run.routes.list, run.services.create, run.services.delete, run.services.get, run.services.getIamPolicy, run.services.list, run.services.setIamPolicy, run.services.update]. Please enable the corresponding APIs to use those permissions.

# Note: permissions [serviceusage.quotas.get] are in 'TESTING' stage 
# which means the functionality is not mature and they can go away in 
# the future. This can break your workflows, so do not use them in 
# production systems!

# Are you sure you want to make this change? (Y/n)?  y

# ERROR: (gcloud.iam.roles.create) INVALID_ARGUMENT: Permission resourcemanager.projects.list is not valid.

gcloud iam roles create cloudeditor --project=$GOOGLE_PROJECT_ID  --file=role_creation_yaml.yaml