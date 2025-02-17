## Check if the container run correctly:

In radian terminal run:
`gitOption("bitmapType")`

then if:
- the answer is `"cairo"` perfect!
- otherwise *Rebuild and Reopen the container* until the option `bitmapType` is `"cairo"`.
- Alternatively open a new zsh terminal (inside the container) and launch `radian`. It should automatically pick "cairo" as graphic device.

## Setting R Development Environment with VScode

So far, we reviewed the foundation of Docker. We saw how to set and build an image with the Dockerfile and the build command, respectively, and then run it in a container with the run command. This section will focus on setting up an R development environment with VScode which includes:

- Set a Dockerfile with the R environment settings
- Define the Dev Containers extension settings


## General Requirements
Before we start setting up our R development environment, let's define the scope:

- R version 4.4.2
- R core packages (e.g., tidyverse, plotly, shiny)
- Quarto version 1.6.40
- Support interactive R applications such as Shiny app, htmlwidget, etc.
- Plot viewers
- Tables viewer
- Help viewer

In addition, we will use `radian` to run R on the command line. **Radian** is an alternative R console with code completion and syntax highlight features.

**NOTE:** Last but not least, we will build the image to enable us to update, modify, and add new components seamlessly.

## Image Build Approach

Here are the main options for setting image with R environment from simple to complex:

- Pull a built-in and ready-to-use image from an external source such as the ones available on the Rocker project.
- Pull a built-in image but add additional layers (e.g., required packages, etc.)
- ***Build the image (almost) from scratch***

Generally, I recommend using a robust and well-tested image as your baseline when applicable. This will save you or reduce the build time and potential debugging or handling dependencies issues. The Docker Hub is a good place to look for such images, and in the context of R, Rocker is the first place to check. 

HERE we will go with the last option (***Build the image (almost) from scratch***) for learning purposes.

It means that the starting point would be a clean and minimal Ubuntu image, which comes without the core R dependencies such C, C++, and Fortran compilers.<br/>
In addition, we will have to set and define R's core configuration options, which, by default, in a regular OS such as Windows or macOS, you won't have to set or define.
To ***make this process seamless and easy to update and modify*** if needed, we will use:

- **Environment variables** to define the core properties of the R environment, such as R and Quarto version, default CRAN mirror, etc.
- A **JSON file (packages.json)** with a list of required packages and their versions


This will enable to update the environment just by updating the ***environment variables*** and the ***packages.json*** file.

## DOCKERFILE - Installing required Dependencies
# Step 3 - Install R dependencies
```
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils\
    gfortran \
    git \
    g++ \
    libreadline-dev \
    libx11-dev \
    libxt-dev \
    libpng-dev \
    libjpeg-dev \
    etc...
```
As we are setting the R environment almost from scratch, there is a long list of dependencies. This includes some Debian dependencies that are required to install R and some of the packages and command line tools. We use the RUN command to execute apt-get command to install those dependencies. One of the main challenges in this type of build is to identify what dependencies required them in the first place. While it is not in the scope of this tutorial, here are some tips:

- **Build log** - when the build fails, the build log provides information about the error type or failure reason. By default, the docker build returns a concise output, which may not contain the error information. To get the full build log output, set the progress argument as plain (--progress=plain)
- **System requirements** - when adding a new R package, check the package description to see if the SystemRequirements section is available. For example, *one of the R environment requirements is the **httpgd** package* that *enables running interactive R applications in VScode*, such as **Shiny** applications, or *HTML widgets*, such as **Plotly**. The package description provides the package system requirements (as can be seen in Figure 11 below) - **C++17**, **libpng**, **cairo**, **freetype2**, **fontconfig**, which must be installed before installing this package

More details here: [Link](https://github.com/RamiKrispin/vscode-r?tab=readme-ov-file)

## Installing R

This section focuses on the 4th step - installing R and setting it. This includes the following sub-steps:

- Install R from CRAN
- Config and set R
- Install packages
- Install Quarto
- Set the R profile
We use the wget package (a command line application for downloading files from websites) to pull the R installation file as a tar file, extract it, and install it. Note that we use the arguments we set in step 2 to define the R version (default is 4.3.1):

RUN wget https://cran.rstudio.com/src/base/R-${R_VERSION_MAJOR}/R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz && \
    tar zxvf R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz && \
    rm R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}.tar.gz

After we installed R inside the image, the next step is configuring it. <br/>
We set the working directory and use the CONFIGURE_OPTIONS variable to define the R graphic and font settings:

The WORKDIR command defines the folder we installed R as the default folder.<br/>
`WORKDIR /R-${R_VERSION_MAJOR}.${R_VERSION_MINOR}.${R_VERSION_PATCH}`

We use the make package to define the default settings and set the default fonts.<br/>
`
RUN ./configure ${CONFIGURE_OPTIONS} && \
    make && \
    make install
`
`RUN locale-gen en_US.UTF-8`


## Installing R packages

To install the required R packages, we will use the following helper scripts:

- ***packages.json*** - A JSON file with a list of required packages and their versions
- ***install_packages.R*** - A R script that parses the JSON file and installs the packages

In the next step below, we set the root folder as the default, create a new folder named settings, and copy the above files to the settings folder:
```
WORKDIR /root

RUN mkdir settings

COPY packages.json install_packages.R requirements.txt install_quarto.sh ./settings/
```

Note: In addition to the packages.json and install_packages.R files, we also copied the requirements.txt and install_quarto.sh files which will be used to set the radian package and install Quarto

Next, we execute the R script we copied to the settings folder:

RUN Rscript ./settings/install_packages.R

Note: The package installation process might take a few minutes. There are a few methods to speed up the process, such as installing the packages using the binary build or using renv, but it is outside the scope of this tutorial.

## Setting the R profile

The last step in this process is to copy the .Rprofile file to the root folder:

`COPY .Rprofile /root/`

The *.Rprofile* file allows us to set global configurations that R loads during the launch of a new session.

## Installing radian

We will use Radian to run R code on the terminal. <br/>
Radian is a Python library that provides an interactive and colorful wrapper to the native R. It includes features such as:

- Code completion
- Syntax highlight

To install radian, we will first *set up a virtual environment with venv*:
```
RUN python3 -m venv /opt/$VENV_NAME  \
    && export PATH=/opt/$VENV_NAME/bin:$PATH \
    && echo "source /opt/$VENV_NAME/bin/activate" >> ~/.bashrc
```

In the virtual environment, we can install radian. <br/>
We will use the pip3 command with the requirements.txt file to install radian:
```
RUN pip3 install -r ./settings/requirements.txt
```

Generally, since in this specific case requirements.txt install only radian we could simply use:
```
RUN pip3 install radian
```

## Customize R environment (packges installed)

The main goal of using arguments and environment variables with the Dockerfile is to enable modification and update the R environment. For example, as mentioned above, the R version is defined with the R_VERSION_MAJOR, R_VERSION_MINOR, and R_VERSION_PATCH arguments.

The ***packages.json*** file defines the list of packages to install during the build time.

For running R with VScode, we need the following two packages:

- **languageserver** - An implementation of the Language Server Protocol for R, required for setting R in VScode
- **httpgd** - Asynchronous HTTP server graphics device for R, used for viewing graphic applications in VScode


In addition, to demonstrate some of the core use cases of R with VScode (e.g., graphic, interactivity, working with Shiny, etc.), we install the following packages:
- **shiny**
- **plotly**
- **tidyverse**
  
The ***packages.json*** file enables o seamlessly set, update, and modify the installed packages and their versions. <br/>
One thing to *note is that when adding new packages, you may need to install additional Debian dependencies (i.e., step 3)*. In some cases, those dependencies are specified on the package DESCRIPTION file. In other cases, when the build fails during the package installation, you will have to extract the missing dependencies from the error log.

## Setting the Dev Continer (devcontainer.json file)

The Dev Containers extension enables isolating a VScode session inside a containerized environment. <br/>
By default, it mounts the local folder to the container and enables the mount of other local folders as well. <br/>
This solves the container ephemeral issue and enables "enjoy" both worlds:
  - running the code in an isolated environment
  - keeping changes in the code locally (and not vanish in the ephemereal container)

The devcontainer.json defines the environment settings and enables the customization of the image settings. That includes the following settings:

- Image settings
- Extensions settings
- Environment variables
- Mount additional folders

## The settings.json File

By default, VScode uses the default settings defined in the settings menu. However, there might be situations where you want to customize the settings on a project level. In such cases, you can make use of the settings.json file. By adding the settings.json file to your project folder under the .vscode folder, you can modify and override the default settings of VScode on a project level. This gives you complete control over the settings you want to use for your project.

Below is the settings.json file we use in this repo to customize the functionality of the R for VScode extension:
```
{
    "r.alwaysUseActiveTerminal": true,
    "r.bracketedPaste": true,
    "r.sessionWatcher": true,
    "r.plot.useHttpgd": true,
    "r.lsp.diagnostics": false
}
```
You can notice from the structure of the JSON file that settings use the following structure:
```
{
"Extension Name.Argument": Value
}
```

where:

- `r.alwaysUseActiveTerminal` - or always use active terminal, when set to true, it will send the R code by default to an open session (as opposed to opening a new terminal)
- `r.bracketedPaste` - or bracketed paste, when set to true, will send an R code with brackets to the terminal. If set to false, any code with a bracket (e.g., for loop, if statement, etc.) will end up with an error.
- `r.sessionWatcher` - or session watcher, when set to true, enables VScode to maintain the connection with an open R session in the terminal
- `r.plot.useHttpgd` - or plot use httpgd, when set to true, will use the httpgd-based plot viewer instead of the base VScode R viewer
- `r.lsp.diagnostics`: false - disable the default lintr diagnostic function via the language server package (you can set it to true if you find it useful)
More information about the R for VScode extension settings available [here](https://github.com/REditorSupport/vscode-R/wiki/Extension-settings).

