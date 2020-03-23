# The Demo Folder

This folder contains the main project files for this course.

## Workflow

The one file students will need on their machine is the adms.deploy.ps1 file. It executes Azure CLI commands that pull the other needed files from the authors github site.

This architecture was chosen for two reasons. First, it ensures the latest updates are always available to students, Azure changes so often that frequent updates may be required.

Second, during the creation of the Windows Server (more on that in a moment) it needs to pull a PowerShell script from somewhere in order to generate the sample database. It made sense then to use a single source to pull *all* the demo files from.

When students execute the commands in the adms.deploy.ps1 file, it will deploy an Azure template, adms.deploy.json, along with it's accompanying adms.parameters.json file. This template does a lot of work.

First, it sets up a virtual Windows Server with a SQL Server installed on Azure. This machine will act as our "on-premises" database for this course. In addition, during deployment the file AddDatabaseToSQLServer.ps1 is executed, creating the sample database we'll use as a source for our migration project.

Next, it creates an Azure SQL Server. In it we need an empty database to be the target for our migration. An empty database is included in the demo files, Pluralsight.bak. The template restores that empty bak file to the new Azure SQL Server. 

In addition, the template also sets up all the required infrastructure bits such as the storage account, disks, and a virtual network.

## File Contents

* AddDatabaseToSqlServer.ps1 - This script creates the sample database on the virtual Windows SQL Server.
&nbsp;
* adms.deploy.json - The deployment template.
&nbsp;
* adms.deploy.ps1 - The main script to execute, it will generate the needed objects from the template.
&nbsp;
* adms.parameters.json - The parameters file that works with the deployment template.
&nbsp;
* Pluralsight.bak - A backup of an empty SQL Server database that will be restored to the new Azure SQL Server created by the template.

## Author Information

### Author

Robert C. Cain | @ArcaneCode | arcanecode@gmail.com 

### Websites

Main Site: [http://arcanecode.me](http://arcanecode.me)
Github: [http://arcanecode.gallery](http://arcanecode.gallery)

### Copyright Notice

This document is Copyright (c) 2019, 2020 Robert C. Cain. All rights reserved.

The code samples herein is for demonstration purposes. No warranty or guarantee is implied or expressly granted.

This document, or the code samples that it accompanies, may not be reproduced in whole or in part without the express written consent of the author. Information within can be used within your own projects.
