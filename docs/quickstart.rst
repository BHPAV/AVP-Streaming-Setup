Quick-Start Guide
=================

Follow these steps to get **AVP Sunshine** running on Windows:

1. **Install via Package Manager**

   • **Chocolatey**::

       choco install avp-sunshine -y

   • **Scoop**::

       scoop bucket add avp https://github.com/AVP-Streaming-Setup/scoop-bucket.git
       scoop install avp-sunshine

2. **Run initial setup cmdlet**

   Open an elevated PowerShell prompt and execute::

       Install-AVPSunshine

   This ensures Sunshine is installed, the service is configured, and firewall rules are applied.

3. **Complete Sunshine first-run wizard**

   Launch your browser and navigate to `https://localhost:47990` to finish the configuration.

4. **Pair your streaming client**

   Pair Moonlight or another Sunshine-compatible client with your PC to start streaming.

For advanced configuration and troubleshooting, consult the rest of the documentation. 