script on how to use gcloud to create a custom role:

```create_editor.sh```

 get info about base role editor and save to txt file (as it can be a big one)

 ```gcloud iam roles describe roles/editor```

```gcloud iam roles describe roles/editor > editor_info.txt```

```gcloud iam roles describe roles/cloudfunctions.admin >> editor_info.txt```

dump all the permissions in a yaml file

```grep -ir - editor_info.txt >> role_creation_yaml.yaml ```

get info about your custom role:

```gcloud iam roles describe cloudeditor --project=$GOOGLE_PROJECT_ID```

```gcloud projects get-iam-policy $GOOGLE_PROJECT_ID --format=yaml > tmp_policy.yaml```

this file has info on how to grand a service account your new role:

```sh grant_acc_access.sh```
