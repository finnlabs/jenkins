# Jenkins Docker image

Our new CI at https://ci.openproject.com is now using this image for running
jenkins.

You can choose to update the list of base plugins by modifying the
`plugins.txt` file and rebuilding the image.

However, you can also just install plugins via the UI, and the backup and
restore scripts that are living on the EC2 instance where this is deployed will
take care of reinstalling jenkins with whatever you've installed via the UI.

The EC2 instance where this is running is installed with a CloudFormation
template from https://github.com/finnlabs/ops.
