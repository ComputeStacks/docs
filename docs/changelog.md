# Change Log

## v7.1.1

_Mar 29, 2022_

* [FIX] Resolve issue with orphanied collaboration records.

***

## v7.1.0

_Mar 21, 2022_

* [FEATURE] Wordpress Integration Beta

***

## v7.0.2

_Feb 16, 2022_

* [FEATURE] Allow default domain to be set via the API.
* [CHANGE] Remove last part of existing metdata api (phpMyAdmin moved to new metadata service).
* [FIX] Bug fixes with our vagrant image.

***

## v7.0.1

* [FEATURE] Brand new vagrant image to aid in development.
* [CHANGE] Allow containers within a project to be linked by role, rather than a specific version.
* [FIX] Rollback libravatar service to gravatar due to performance issues.

***

## v7.0.0

_Jan 1, 2022_

* [CHANGE] License changed to AGPL.
* [FEATURE] SSH Keys for SFTP Containers and configurable password authentication.
* [FEATURE] Download connection profiles for Filezilla and Transmit.
* [FEATURE] Switch from gravatar to libravatar.
* [FEATURE] Set a global motd for all sftp containers. (Admin)
* [FEATURE] Moved metadata service to distributed database within each availability zone.
* [FEATURE] Improvements to global search. (Admin)
* [CHANGE] Allow udp and tcp to share the same port
* [CHANGE] Provide feedback on how a user can change their profile pic
* [CHANGE] Show user profile pics in admin

***

## v6.4.3

_November 12, 2021_

* [FIX] Fixed regression in bandwidth billing calculation.

***

## v6.4.2

_November 8, 2021_

* [FIX] Containers with no volumes would fail to migrate with nfs storage.

***

## v6.4.1

_October 27, 2021_

* [CHANGE] Collaborators can no longer delete the parent resource.
* [FIX] A resource could no longer be deleted if it had collaborators.

***

## v6.4.0

_October 20, 2021_

* [FEATURE] Project collaborators.

***

## v6.3.3

_Sep 21, 2021_

* [FEATURE] Search by private IP of container.

***

## v6.3.2

_Sep 8, 2021_

* [FEATURE] Additional container resource limits. Open file limits, pid limits, and disk IOPS limits.

***

## v6.3.0

_Aug 26, 2021_

* [FEATURE] Optionally delete stopped containers from container nodes. This also includes an option to override that setting on a per-image, or per-container service (admin only).
* [FEATURE] Choose whether or not to bill for stopped containers.
* [FEATURE] Option to stop billing when a user is suspended.
* [FEATURE] Admins can now manually pull (update) a global image on all nodes.
* [FEATURE] New admin api endpoint to show allocated resources within a region.

* [CHANGE] Include project details in email notifications.

* [FIX] Resolve issue that prevented creating products with the admin api.
* [FIX] Display correct sftp container IP address in admin interface.
* [FIX] Allow setting daily retention setting for backups.

***

## v6.2.7

_Aug 6, 2021_

* [FEATURE] Display billing module connection status on settings page.
* [FIX] CPU and Memory were swapped on the admin dashboard.
* [FIX] Missing error message when adding ingress rule without a port.
* [FIX] When updating the billing module, the current module would not be selected.

***

## v6.2.6

_July 27, 2021_

* [FEATURE] Ability to organize packages by groups
* [CHANGE] Include user's aggregated total unprocessed usage in all user api endpoints.
* [CHANGE] Refresh package list UI
* [CHANGE] Additional search options for the admin users api.

***

## v6.2.5

_July 11, 2021_

* [CHANGE] Added ingress rules to container api.

***

## v6.2.4

_June 30, 2021_

* [CHANGE] Include project info in the api call to list container services.
* [CHANGE] You can now view and edit existing SSL certificates. (Previously you had to upload a complete new bundle)
* [FIX] Resolve issue that may have prevented some old ssl certificates from being cleaned up.
* [FIX] Resolve usage aggregation error when a product was removed from a billing plan, but a service was still active. Same issue also affected the auto-scaling UI.

***

## v6.2.3

_June 21, 2021_

* [FEATURE] Support resyncing sftp containers in both admin and end-user interface.
* [FIX] Error that prevented certain products from being added to a billing plan.
* [FIX] Reset SFTP password via api.
* [FIX] Backup restore api.

***

## v6.2.2

_June 8, 2021_

* [FEATURE] Support for adding a logo to email templates.
* [FIX] Resolve issue that would not place scaled containers on the node that had their volume.
* [FIX] Resolve issue with phpMyAdmin accessing it's configuration from the controller.
* [FIX] Various bug fixes.

***

## v6.2.1

_May 25, 2021_

* [FIX] Correctly recover ssh containers.
* [FIX] Bug when viewing environmental vars for a service.

***

## v6.2.0

_May 14, 2021_

* [FEATURE] Ability to disable SSH containers at a per-project level (via the API only, and only at creation).
* [FEATURE] Support for creating public IP networks.
* [FEATURE] Manage settings for a service after it's deployed (previously only possible with images).
* [FEATURE] Full ingress rule management (previously only available via the API)
* [FEATURE] U2F Security Keys have been upgraded to WebAuth (FIDO 2).
* [FEATURE] Ability to prevent overcommitting cpu or memory on a node.
* [FEATURE] Place containers within an AZ or node based on the allocated resources, rather than just the quantity of containers.
* [FEATURE] Support for excluding directories from backups by using: echo "Signature: 8a477f597d28d172789f06886806bc55" > CACHEDIR.TAG

* [CHANGE] **Important:** Any container that bypasses the load balancer will now be billed for _all_ data sent from that container, including inter-project bandwidth.
* [CHANGE] Updated Container Service layout
* [CHANGE] Switch to fluentd for container log aggregation on each node.

* [FIX] Resolved issue that prevented correct amount of swap from being applied to containers.
