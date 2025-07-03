Below is a step‑by‑step roadmap that an LLM‑powered assistant (for example, ChatGPT plus the GitHub API) can follow to turn the one‑off PowerShell bootstrapper into a fully managed, open‑source “AVP Streaming Setup” project.  The plan is opinionated but modular so you can adopt it piecemeal or end‑to‑end.

⸻

0 – Executive Overview (what you will end up with)
	•	A GitHub repository that contains:
	•	Idempotent PowerShell modules that install and configure Sunshine on Windows.
	•	Automated CI/CD to lint, test, sign, and publish new releases.
	•	Chocolatey & Scoop packages so users can choco install avp‑sunshine or scoop bucket add domo && scoop install avp‑sunshine.
	•	Human‑friendly docs (Sphinx → GitHub Pages) and ready‑made issue/PR templates.
	•	Continuous dependency hygiene via Dependabot and formatting checks via pre‑commit hooks.

This guide is ordered so an AI agent can execute one section at a time and open a pull‑request per milestone.

⸻

1 – Repository Scaffolding

1.1  Create the repo

Folder/file	Purpose
/src/AVPSunshine/	Re‑usable PowerShell module(s)
/examples/	Working scripts for manual execution
/packaging/choco/ & /packaging/scoop/	Package specs
/docs/	Sphinx source
/.github/	Workflows, issue/PR templates
LICENSE (MIT)	Simple OSS license so packagers feel safe  ￼

LLM task: call the GitHub API POST /repos with the desired org/name and default branch main.

1.2  Add semantic version tags

Adopt SemVer 2.0.0; the AI should refuse non‑compliant tags in CI  ￼.

⸻

2 – Source Code

2.1  Modularise the bootstrapper

Convert the monolithic script you drafted into a PowerShell module (AVPSunshine.psm1) exporting cmdlets such as:

Install‑AVPSunshine
Enable‑AVPSunshineFirewall
Start‑AVPSunshineService

Each cmdlet wraps one labelled block from your prototype.

2.2  Unit tests

Use Pester in /tests/ to validate:
	•	Sunshine service exists and is set to Automatic.
	•	Required ports are open with Get‑NetFirewallRule.

GitHub provides examples for Pester in Actions runners  ￼.

⸻

3 – Documentation

3.1  Write in reStructuredText & build with Sphinx

Sphinx is easy to host on GitHub Pages and supports autodoc for PowerShell via sphinx‑ext‑autodoc2  ￼.

3.2  Enable GitHub Pages

Add a workflow that runs sphinx-build on every push to main and publishes docs/_build/html to the gh-pages branch using the standard pages‑deploy action  ￼.

⸻

4 – Packaging for Windows Users

4.1  Chocolatey

Create nuspec and tools/chocolateyInstall.ps1 in /packaging/choco/, following Chocolatey’s “create package” guide  ￼.

LLM task: auto‑update the download URL in chocolateyInstall.ps1 by scraping the latest Asset URL for *-installer.exe from the Sunshine release API  ￼.

4.2  Scoop

Write a JSON manifest (avp‑sunshine.json) and place it in a custom bucket repo.  Scoop manifests specify version, URL, hash, and install script  ￼.
Document how to scoop bucket add that repo; buckets are just Git repos  ￼.

⸻

5 – Continuous Integration & Release Automation

5.1  GitHub Actions workflow matrix
	•	Lint & test: run PSScriptAnalyzer + Pester on windows-latest.
	•	Package: on a Git tag, build the Chocolatey .nupkg and Scoop manifest, then attach them to the release.
	•	Sign: if you own a code‑signing cert, call signtool.exe in a secure step.

Reusable workflow syntax is documented in GitHub Actions reference  ￼.

5.2  Publish to Chocolatey Community & Scoop bucket

Add secrets CHOCO_API_KEY and GIT_TOKEN; push from CI.

⸻

6 – Repository Hygiene & Governance

Tool	Why	Key file
Dependabot	Auto‑PRs for new Sunshine releases & module deps  ￼	/.github/dependabot.yml
pre‑commit	Enforce pwshfmt, JSON/YAML lints before commit  ￼	.pre-commit-config.yaml
Issue & PR templates	Standardise bug reports & feature requests  ￼ ￼	/.github/ISSUE_TEMPLATE/

The LLM should create these files once, then merely update label lists when new modules are added.

⸻

7 – End‑User On‑Boarding

Add a Quick‑Start doc that says:
	1.	choco install avp‑sunshine or scoop install avp‑sunshine.
	2.	Run Install‑AVPSunshine.
	3.	Browse to https://localhost:47990 and complete first‑run wizard  ￼.
	4.	Pair Moonlight XrOS via TestFlight link  ￼; source code is on GitHub  ￼.

⸻

8 – Release Cadence & Roadmap
	•	Patch (x.y.Z): dependency bumps or bug fixes.
	•	Minor (x.Y.0): new flags, e.g., automatic virtual‑display driver install.
	•	Major (X.0.0): breaking changes (e.g., move from Sunshine to official Microsoft Windows App when it gains encoder parity).

Tag each milestone using SemVer rules right in the workflow to fail the build if git describe --tags is invalid  ￼.

⸻

9 – LLM Agent Workflow
	1.	Read open issues via GitHub API; pick the next “good first issue.”
	2.	Draft code → open PR; include unit tests and doc stubs.
	3.	Run CI locally using act or on a fork to ensure green checks.
	4.	Ask for human review; incorporate feedback; merge.
	5.	Trigger release workflow on merge to main with release/* label.

⸻

10 – Future Enhancements
	•	Auto‑detect WSL2 GPU passthrough and warn users if missing.
	•	Add macOS support by calling Apple Script to toggle Mac Virtual Display.
	•	Integrate with Meshnet/VPN recipes so Sunshine works off‑LAN.

⸻

Next Action for the Assistant
	1.	Create the repo with the scaffold (Section 1).
	2.	Commit the initial PowerShell module and Pester tests (Sections 2 & 3).
	3.	Open PR #1 titled “feat(core): initial bootstrap module”.

Once merged, the CI pipeline will build docs and you’ll have the foundations of a polished, reproducible AVP streaming toolkit.