# Tools for lazy people

## Purpose

I got tired of losing scripts I wrote and kept rewriting over and over again. This repository is a dumping ground for those things. Nothing comes with a gaurantee and a majority is going to be things bodged together with duct tape and discarded man pages. I'll do my best to keep things updated and feel free to hack away on anything if you think you can make it less trash.

## Active Projects

I'm sure GitHub has a better way to track projects but I'm a lazy person and haven't figured it out yet. That should be apparent from my commit history and comments, though.

Currently working on the following things:

### AD User Checkup

    * The ideal outcome for this is an easy overview of current user metric you'd typically look at if you were trying to troubleshoot and account level issue.
    * This would include:
        * OU
        * Password status
        * Diff between groups assigned to user versus the users in the OU (this is mostly done)
        * Physical Location information
        * Last device logged in to (This will be hard to implement)
        * Current devices logged in to (this will be difficult but not impossible)
    * I'd also like for some basic user account troubleshooting tasks to be intergrated in to it like:
        * User group homogenization
        * Password unlock
    * It'd be cool if it auto refreshed to track changes as well, but not required.

### Summarize-ADPrincipleMembership

    * This tool is the one I'm working on primarily to get more comfortable with Powershell, so it's going to be the most hackish tool I work on for now.
    * This tool already works but I'd like to implement the following:
        * Selectable input between OU path name and SAM account name
        * Diff function between current user and rest of OU location
        * Confirmation dialogue for SAM account option to have technician verify that the OU the user is in is the correct OU
        * Usable both as a CLI tool and as a proper CMDlet so it can be intergrated in to the larger AD user checkup tool.

Any other script I have here is just a dumped script that I might need or that I took from somewhere else. If you have any questions you probably know me as a person so contact me via the channels you know how to contact me by.

### Testing GitKraken out. Time to push it real good
