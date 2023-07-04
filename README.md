# Compendium of ACS CyTOF T Cells

## Instructions for setting up

- **Open in GitHub online dev environment**
  - Run `github.dev/<organisation_name>/<repo_name>`
- **Set R version**
  - Press `Ctrl + Shift + F` to open text search through entire repo
  - Search for `430` 
  - Change to desired R version, wherever it appears
   - Options: `363`, `413`, `423` and `430`
  - Set R version in `devcontainer.json`:
    - Open `.devcontainer/devcontainer.json`
    - Under `features/"ghcr.io/rocker-org/devcontainer-features/r-rig:1"/version`, change the version to desired version
  - Commit the changes to Git
- **Change the following references**:
  - Use `Ctrl + Shift + F` to open text search through entire repo again:
    - Replace `Comp<old_comp>` with `Comp<new_comp>`
- **Update repos to clone**:
  - In the file `repos-to-clone.list`, add GitHub repos to clone (one per line, in `<org_name>/<repo_name>` format)
  - Add all these repos to the VS Code workspace file `EntireProject.code-workspace`
    - Use the same format as is already there, just copying down
- **Create singularity file**
  - Open in a GitHub Codespace, GitPod workspace or Linux locally
  - Run 


## Instructions for running

### Initial configuration

In all cases, make sure that you have the environment variable `GH_TOKEN` set up to a GitHub token with `repo`, `user` and `workflow` scopes
from a GitHub account that has access to the following repositories:

- SATVILab/DataTidyACSClinical
- SATVILab/DataTidyACSCyTOFPreprocess
- SATVILab/DataTidyACSCyTOFFAUST
- SATVILab/PipelineDataACSCytokines
- SATVILab/DataTidyACSCyTOFCytokinesTCells
- SATVILab/PipelineAnalysisACS
- SATVILab/AnalysisACSCyTOFTCells
- SATVILab/ReportACSCyTOFTCells

#### Seting up `GH_TOKEN` environment variable

First, you need to create the token (Getting secret) and then you need to make it available in your environment (GitHub Codespaces, GitPod or HPC).

**Getting secret**

- Go to `https://github.com/settings/tokens`
  - Click `Generate new token`
  - Click `Generate new token (classic)`
  - Name the token something meaningful
  - Select the following scopes:
    - `repo`
    - `user`
    - `workflow`
  - Click `Generate token`

**GitHub Codespaces**: Set up `GH_TOKEN` in the Codespaces settings

- Go to `https://github.com/settings/codespaces`
- On the right of `Codespaces Secrets`, click `New secret`
- Name the secret `GH_TOKEN`
- Paste the token into the `Value` field
  - Get this

### GitPod

- Open `https://gitpod.io/#https://github.com/SATVILab/Comp23RodoSTA2005S`
  - Wait for set-up to complete (including post-image creation commands)
- Open a terminal:
  - *Authenticate to GitHub*: Run `gh auth login`
    - Follow instructions
  - *Download container image*: Run `mkdir -p sif && gh release download --repo SATVILab/Comp23RodoSTA2005S r430 --pattern sif --dir sif --skip-existing`
  - *Open VS Code using a remote tunnel into container*: Run `apptainer exec sif/r430.sif code tunnel --accept-server-license-terms`
    - Follow instructions, up until you then have a browser tab open to a VS Code instance
- Switch to VS Code instance:
  - Open a VS Code workspace:
    - Press `Ctrl + Shift + P`
    - Choose `File: Open Workspace from File...`
    - Open workspace with repos of interest:
      - `EntireProject.code-workspace`: Contains all repos
      - `DataTidy.code-workspace`: Contains data-processing repos
      - `Analysis.code-workspace`: Contains analysis repos

### GitHub Codespaces

- *Open Codespace*:
  - Go to `https://github.com/SATVILab/Comp23RodoSTA2005S`
  - Click green `Code` button
  - Click green `Create codespace on main` button
  - Wait for set-up
- Switch to VS Code instance:
  - Open a VS Code workspace:
    - Press `Ctrl + Shift + P`
    - Choose `File: Open Workspace from File...`
    - Open workspace with repos of interest:
      - `EntireProject.code-workspace`: Contains all repos
      - `DataTidy.code-workspace`: Contains data-processing repos
      - `Analysis.code-workspace`: Contains analysis repos

### HPC

- Open *terminal*: Open an interactive terminal on a compute node
- *Ensure that `apptainer` is loaded*
  - Run `apptainer --version` to check
    - If it's not, then you'll need to load it somehow (e.g. `module load apptainer`). Ask your system administrator (or hopefully-more-knowledgeable colleague) if you're not sure how to do this.
- *Clone this repository*:
  - Navigate to directory where you want to clone this repo and all other project repos.
    - Note that there are many project repos, so it would be good to do this in its own directory.
      - We create `ProjectACSCyTOFTCells` folder for this purpose.
    - Inside that folder, run `git clone https://github.com/SATVILab/Comp23RodoSTA2005S.git`
- *Open terminal inside repo*:
  - Run `cd <path/to/Comp23RodoSTA2005S>`
- *Download the container image*:
  - Using a terminal: Run `.src/hpc/download_apptainer.sh`.
  - Using GUI: Go to `https://github.com/SATVILab/Comp23RodoSTA2005S/releases/tag/r430` and download `r430.sif` to `sif` folder (run `mkdir -p sif` to create folder first).
- *Open VS Code using a remote tunnel into container*: Run `apptainer exec sif/r430.sif code tunnel --accept-server-license-terms`
    - Follow instructions, up until you then have a browser tab open to a VS Code instance
- Switch to VS Code instance:
  - Open a VS Code workspace:
    - Press `Ctrl + Shift + P`
    - Choose `File: Open Workspace from File...`
    - Open workspace with repos of interest:
      - `EntireProject.code-workspace`: Contains all repos
      - `DataTidy.code-workspace`: Contains data-processing repos
      - `Analysis.code-workspace`: Contains analysis repos

### Local (Linux)

This is if you have Linux set up locally (perhaps using Windows Subsystem for Linux).

In this case, the instructions are basically the same as for the HPC.

- *Open a terminal*
- *Clone this repository*:
  - Navigate to directory where you want to clone this repo and all other project repos.
    - Note that there are many project repos, so it would be good to do this in its own directory.
      - We create `ProjectACSCyTOFTCells` folder for this purpose.
    - Inside that folder, run `git clone https://github.com/SATVILab/Comp23RodoSTA2005S.git`
- *Ensure that `apptainer` is installed*
  - Run `apptainer --version` to check
    - If it's not, then you can run `./src/hpc/install_apptainer.sh` to install apptainer.
- *Open terminal inside repo*:
  - Run `cd <path/to/Comp23RodoSTA2005S>`
- *Download the container image*:
  - Using a terminal: Run `.src/hpc/download_apptainer.sh`.
  - Using GUI (if terminal doesn't work): Go to `https://github.com/SATVILab/Comp23RodoSTA2005S/releases/tag/r430` and download `r430.sif` to `sif` folder (run `mkdir -p sif` to create folder first).
- *Open VS Code using a remote tunnel into container*: Run `apptainer exec sif/r430.sif code tunnel --accept-server-license-terms`
    - Follow instructions, up until you then have a browser tab open to a VS Code instance
- Switch to VS Code instance:
  - Open a VS Code workspace:
    - Press `Ctrl + Shift + P`
    - Choose `File: Open Workspace from File...`
    - Open workspace with repos of interest:
      - `EntireProject.code-workspace`: Contains all repos
      - `DataTidy.code-workspace`: Contains data-processing repos
      - `Analysis.code-workspace`: Contains analysis repos

### Local (other)

In this case, this repository is not particularly useful to you so you might as well just clone individual repos and open them inside VS Code/RStudio.
- Well, this is not entirely true - you could clone this repo and then use the workspace files it provides. But that's not amazingly useful.

So, for this approach:

- Create a project folder to contain all the repos.
- Clone all the repos to that project folder. You can use this script:

```
git clone https://github.com/SATVILab/DataTidyACSClinical.git
git clone https://github.com/SATVILab/DataTidyACSCyTOFPreprocess.git
git clone https://github.com/SATVILab/DataTidyACSCyTOFFAUST.git
git clone https://github.com/SATVILab/PipelineDataACSCytokines.git
git clone https://github.com/SATVILab/DataTidyACSCyTOFCytokinesTCells.git
git clone https://github.com/SATVILab/PipelineAnalysisACS.git
git clone https://github.com/SATVILab/AnalysisACSCyTOFTCells.git
git clone https://github.com/SATVILab/ReportACSCyTOFTCells.git
```
