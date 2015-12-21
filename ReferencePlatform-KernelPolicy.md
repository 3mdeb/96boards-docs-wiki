## Why
The Reference Kernel is the combination of both LEG and the 96Boards RP topic branches. LEG members will submit their kernel topics to LEG for inclusion.  At this point, the 96Boards Reference Platform will be based on the LEG tree.  In cases where the SoC vendor is not part of LEG, the 96Boards Reference Platform will serve as the primary branch.

The end result, members of Linaro will in combination contribute to a kernel branch that incorporates the activities and development of all members.   The topics will be targeted towards tip, and rebased once the kernel has moved from -rc to stable.  As in, if the current -rc is for 4.4, then all topics will be based on that kernel.  Once the 4.4 kernel is released, all patches that were not accepted into the kernel release, will be rebased to the next developement kernel.  In the case of this example, rebase from 4.4 to 4.5.

## Rules
1. Patches will not break the single multi-platform kernel that is shipped as part of the RP
1. In general, kernel patches will be accepted in the RP kernel (for staging) only if they’re undergoing review on LKML or other relevant upstream (not @linaro.org) mailing lists first
1. Patches will be dropped from the RP kernel tree in the following cases:
  * Patch has been rejected upstream and maintainer has outlined a different approach to take
  * Patch is showing no sign of progress upstream - either through ongoing discussion or posting of follow-up versions based on earlier reviews
  * Patch doesn’t apply to a newer kernel
1. Changes to common core code will require signoff from the relevant kernel maintainer at Linaro
1. Members will designate an engineer who is responsible for each patch series and will address the questions/comments from the tree maintainers
1. Patches can only be accepted for HW platforms that are shared with Linaro
1. Each out-of-tree patch will be tagged with one of the following keywords to allow easy accounting and tracking their progress upstream:
  * `fromlist`: Patch is picked up from a public mailing list where it is being reviewed
  * `fromtree`: Patch is picked up from a subsystem maintainer tree where it is already queued for merging
  * `temphack`: Patch is needed temporarily until some underlying code is fixed or refactored correctly upstream
  * `noup`: Patch is only needed for enabling pre-production HW or is only needed for local testing and won’t be pushed upstream. It will be fixed correctly upstream
  * `topost`: (to post) Patch isn’t posted to the list yet but posting is imminent. These patches will only be allowed very rarely solely at the discretion of the RP kernel maintainer
1. Statistics will be published regularly on how much functionality is still out-of-tree for each platform and high-level highlights of status of upstreaming for each feature being carried out-of-tree.
