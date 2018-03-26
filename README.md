## PS-Toolbox

### Show Membership

**Usage:** `.\show_membership.ps1 accountname`

Shows a list of all groups the specified account is a member of:

```
Group Membership
----------------
 -  Domain Users
 -  Help Desk
 -  Records Management
```

### Address Digest

**Usage:** `.\address_digest.ps1 accountname`

Prints a report on the specified account showing the account's email addresses, email addresses for groups that include the account, and any account email addresses that forward to that user.

```
Account email addressses
------------------------
[Addresses]

Account Group Membership Addresses
----------------------------------
[Addresses]

Accounts Forwarded to Account
-----------------------------
[Addresses]
```

### About DistGroup

**Usage:** `.\about_distgroup.ps1 groupname`

Shows all email addresses associated with a distribution group, as well as the membership of the distribution group.

```
Email Addresses for groupname
----------------------------------------
 - groupname@org.net

Membership:
 -  John Doe
    john.doe@org.net
```

### Search for Email Address

**Usage:** `\search_for_email.ps1 searchstring`

Searches exchange for email addresses containing the supplied string, then invokes `locate_email.ps1` using the results. 

### Locate Email Address

**Usage:** `.\locate_email.ps1 someemail@org.net`

Searches Exchange for the given email address (both for Mailbox and Distribution Group) and prints the result. If finds a group, shows the delivery addresses for the members.

If Mailbox:

```
Found in User Mailbox:

Name       Alias        ServerName       ProhibitSendQuota
----       -----        ----------       -----------------
John Doe   somealias    aserver          unlimited
```

If Group:

```
Found in Distribution Group:

Name          DisplayName     GroupType      PrimarySmtpAddress
----          -----------     ---------      ------------------
groupname     groupname       Universal      groupname@org.net

Which is delivered to:
 -  John Doe
    john.doe@org.net
```