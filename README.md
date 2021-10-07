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
