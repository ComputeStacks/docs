# Sending Mail

By default, most of [our images](https://hub.docker.com/u/cmptstks) do not include any kind of MTA. This means the default phpmailer, or sendmail, will not function.

However, beginning with our php7.4-based images, we now include postfix that can be configured to relay mail to your SMTP provider of choice. This means you no longer need to configure SMTP in your app, or install a wordpress plugin.

Example SMTP services:

- [Postmark](https://postmarkapp.com/)
- [Sendinblue](https://www.sendinblue.com/)
