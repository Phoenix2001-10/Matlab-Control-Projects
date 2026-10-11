# Publishing These Projects on GitHub

## Option A: One repository for all four projects

From a terminal inside the `matlab-control-projects` folder:

```bash
git init
git add .
git commit -m "Add MATLAB control and dynamics projects"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/matlab-control-projects.git
git push -u origin main
```

Create the empty GitHub repository first and replace `YOUR-USERNAME` with your GitHub username.

## Option B: Four separate repositories

Copy each numbered project folder into its own directory/repository. Suggested repository names:

- `mass-spring-damper-control`
- `dc-motor-pid-control`
- `vehicle-cruise-control`
- `inverted-pendulum-control`

## Before publishing

1. Run every MATLAB script once.
2. Check the generated plots.
3. Add one or two best figures to each README if desired.
4. Change parameters and controller gains yourself and record what you observe.
5. Be prepared to explain every equation and controller choice in an interview or presentation.
