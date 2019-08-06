gcloud pubsub topics create myRunTopic

docker build cloudrun-pubsub/. --tag eu.gcr.io/olivierba-sandbox/nodejscloudrun:v0.1

gcloud beta run deploy pubsub-tutorial --image eu.gcr.io/olivierba-sandbox/nodejscloudrun:v0.1 --region us-central1

gcloud projects add-iam-policy-binding olivierba-sandbox \
     --member=serviceAccount:service-361681312054@gcp-sa-pubsub.iam.gserviceaccount.com \
     --role=roles/iam.serviceAccountTokenCreator


gcloud iam service-accounts create cloud-run-pubsub-invoker \
     --display-name "Cloud Run Pub/Sub Invoker"

gcloud beta run services add-iam-policy-binding pubsub-tutorial \
   --member=serviceAccount:cloud-run-pubsub-invoker@olivierba-sandbox.iam.gserviceaccount.com \
   --role=roles/run.invoker --region us-central1

gcloud beta pubsub subscriptions create myRunSubscription --topic myRunTopic \
   --push-endpoint=https://pubsub-tutorial-7k7ns6tdzq-uc.a.run.app/ \
   --push-auth-service-account=cloud-run-pubsub-invoker@olivierba-sandbox.iam.gserviceaccount.com