# sun_scrape

### manage service acc
more details here:

https://cloud.google.com/iam/docs/creating-managing-service-accounts#undeleting_a_service_account

## how to delete a service account:
`gcloud iam service-accounts delete \
    SA_NAME@PROJECT_ID.iam.gserviceaccount.com`

## how to undelete a service acc:
`gcloud beta iam service-accounts undelete ACCOUNT_ID`


## gcloud:

### how to set a project in gcloud
`gcloud config set project     $PROJECT_ID
`

## Questions:
How do we create a role with more than 3000 permissions?
```
vmmigration.utilizationReports.get, 
vmmigration.utilizationReports.list, serviceusage.quotas.get] are in 
'TESTING' stage which means the functionality is not mature and they 
can go away in the future. This can break your workflows, so do not 
use them in production systems!

Are you sure you want to make this change? (Y/n)?  y

ERROR: (gcloud.iam.roles.create) INVALID_ARGUMENT: The number of permissions in the role is greater than the maximum of 3,000.
[martin@arch scripts]$ gcloud iam roles describe roles/editor | less
[martin@arch scripts]$ 
[martin@arch scripts]$ 
```

Should the terraform config be destroyable? I try to run the `terrafrom destroy` every now and then to check the stability of the config. Is this a procedure which is done in production?



## Known issues

```
╷
│ Error: Error applying IAM policy for cloudfunctions cloudfunction "projects/static-emblem-327016/locations/europe-west2/functions/function-test": Error setting IAM policy for cloudfunctions cloudfunction "projects/static-emblem-327016/locations/europe-west2/functions/function-test": googleapi: Error 403: Permission 'cloudfunctions.functions.setIamPolicy' denied on resource 'projects/static-emblem-327016/locations/europe-west2/functions/function-test' (or resource may not exist).
│ 
│   with module.cloud_function_scrape.google_cloudfunctions_function_iam_binding.invoker,
│   on modules/cloud_function_scrape/main.tf line 56, in resource "google_cloudfunctions_function_iam_binding" "invoker":
│   56: resource "google_cloudfunctions_function_iam_binding" "invoker" {
│ 
╵
```
create a role which provides the required permissions, add it to a service account. See the scripts directory