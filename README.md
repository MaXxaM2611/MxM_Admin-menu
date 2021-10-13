# MxM_Admin-menu
<div align="center">
    <p>
        <a href="https://discord.gg/7d6YbQQVms">
            <img alt="MaXxaM#051" src="https://imgur.com/jsGXHTd.png">
        </a>
    </p>
    <p>
       ⬆⬆  Click Button for Discord ⬆⬆
    </p>
</div>


<h1 class="code-line" data-line-start=0 data-line-end=1><a id="title"></a>MxM Admin Menu</h1>
<h2 class="code-line" data-line-start=1 data-line-end=2><a id="site"></a><a href="https://fenixhub.dev">https://fenixhub.dev</a></h2>
<h1 class="code-line" data-line-start=3 data-line-end=4><a id="Dependencies_3"></a>Dependencies</h1>
<ul>
   <li class="has-line-data" data-line-start="4" data-line-end="5">mysql-async</li>
   <li class="has-line-data" data-line-start="5" data-line-end="7">es_extended (Tested on v1 Final) or legacy</li>
</ul>
<h1 class="code-line" data-line-start=7 data-line-end=8><a id="Noteworthy_Features_7"></a>Noteworthy Features</h1>
<h2 class="code-line" data-line-start=8 data-line-end=9><a id="Ban_sistem"></a>Ban Sistem</h2>
<p class="has-line-data" data-line-start="9" data-line-end="13"> Online and offline ban system through all identifiers and tokens, through the offline ban a single identifier of the player is inserted in the .json file which at the moment it tries to connect the entire list of identifiers and tokens is saved.</p>
<h2 class="code-line" data-line-start=14 data-line-end=15><a id="permission"></a>Permission</h2>
<p class="has-line-data" data-line-start="15" data-line-end="17">Every single function of the menu is configurable from config, every single key can be configured via group (esx) or identifier (any identifier)</p>
<h2 class="code-line" data-line-start=18 data-line-end=19><a id="resmon"></a>Optimization</h2>
<p class="has-line-data" data-line-start="19" data-line-end="21">The script has been created in order to create the least amount of lag both client and server side</p>
<h2 class="code-line" data-line-start=22 data-line-end=23><a id="customization"></a>Customization</h2>
<p class="has-line-data" data-line-start="23" data-line-end="25">Any menu key is configurable directly from the fivem settings</p>
<h1 class="code-line" data-line-start=26 data-line-end=27><a id="ConfigSetting"></a>Config Setting </h1>
<h2 class="code-line" data-line-start=28 data-line-end=29><a id="permission"></a>Permission menu</h2>
<pre><code class="has-line-data" data-line-start="30" data-line-end="38" class="language-lua"><span class="hljs-comment">--config_server.lua :</span>
  {
    group = {"superadmin","admin","mod"},    <span class="hljs-comment">--group that can see the button</span>
    identifier = {"steam:"},                 <span class="hljs-comment">--Identifier that can see the button</span>
    label = MxM_Lang["lista_player"], 	     <span class="hljs-comment">--Translation of the button (found in shared.lua)</span>  
    value = "mxm:ListaPlayer", 	             <span class="hljs-comment">--Don't edit unless you are MaXxaM or know what you are doing xD</span>  
    serverside = false,	                     <span class="hljs-comment">--Don't edit unless you are MaXxaM or know what you are doing xD</span>  
    sub = false,                             <span class="hljs-comment">--Don't edit unless you are MaXxaM or know what you are doing xD</span>   
    namesub = ""                             <span class="hljs-comment">--Don't edit unless you are MaXxaM or know what you are doing xD</span>  
},

</code></pre>
<h2 class="code-line" data-line-start=39 data-line-end=40><a id="Permission"></a>Permission Function</h2>
<pre><code class="has-line-data" data-line-start="43" data-line-end="53" class="language-lua"><span class="hljs-comment">-- Config of each function in the admin menu</span>

  Permission = {

    Ban = {
        ["admin"] = true          <span class="hljs-comment">--Group that can use the function</span>
    },

    Sban = {
        ["admin"] = true        <span class="hljs-comment">--You can add any group on your server</span>
    },
  </code></pre>
  <pre><code class="has-line-data" data-line-start="62" data-line-end="64" class="language-lua"></code>
    <span class="hljs-comment">--If you want only one or more specific people to do that function you can opt to use an identifier as a permission--</span>
  </code></pre>
  <pre><code class="has-line-data" data-line-start="62" data-line-end="64" class="language-lua"></code> 
  IdentiFier = {

    Ban = {
        "steam:8673928176"      <span class="hljs-comment">--Identifier that can use the function</span>
    },

    Sban = {
        "steam:8673928176"       <span class="hljs-comment">--You can use any identifier</span>
    },
</code></pre>
<h2 class="code-line" data-line-start=59 data-line-end=60><a id="Vehicle"></a>Add Vehicle</h2>
<p class="has-line-data" data-line-start="60" data-line-end="61">In the config_server.lua there is a table with the list of vehicles (example vip), which you can give to each player</p>
<pre><code class="has-line-data" data-line-start="62" data-line-end="64" class="language-lua">Vehicle = {
    {label = "Ferrari",     value = "blista"},        <span class="hljs-comment">--Add your label and model for each vehicle to be give</span>
},</code></pre>
<h2 class="code-line" data-line-start=70 data-line-end=71><a id="WEBHOOK"></a>Log Sistem</h2>
<p class="has-line-data" data-line-start="71" data-line-end="73">Any action done by an admin is sent via webhooks to your discord.<br>  
<pre><code class="has-line-data" data-line-start="75" data-line-end="80" class="language-lua">Log = {
    Discord = {
        enable = true,                      <span class="hljs-comment">--if you don't want the logs disable the option by setting false here</span>
        webhook_image   = "Your Webhook",   <span class="hljs-comment">--Create your webhook and add it here <a href="https://www.digitalocean.com/community/tutorials/how-to-use-discord-webhooks-to-get-notifications-for-your-website-status-on-ubuntu-18-04">Guide Create Webhook</a></span>
        webhook_ban     = "Your Webhook",  
        webhook_admin   = "Your Webhook",
    },
},</code></pre>
<h2 class="code-line" data-line-start=83 data-line-end=84><a id="Commans"></a>Commands</h2>
<pre><code class="has-line-data" data-line-start="75" data-line-end="80" class="language-lua">
  <span class="hljs-keyword">/sban  </span>                <span class="hljs-comment">--[ID-BAN] </span>
  <span class="hljs-keyword">/ban  </span>                 <span class="hljs-comment">--[ID]  [REASON]  </span>
  <span class="hljs-keyword">/tempban  </span>             <span class="hljs-comment">--[ID]  [REASON] [EXPIRE] </span>
  <span class="hljs-keyword">/offlineban  </span>          <span class="hljs-comment">--[IDENTIFIER]  [REASON] </span>
  <span class="hljs-keyword">/offlinetempban  </span>      <span class="hljs-comment">--[IDENTIFIER]  [REASON] [EXPIRE] </span>
  <span class="hljs-keyword">/goto  </span>                <span class="hljs-comment">--[ID]</span>
  <span class="hljs-keyword">/gotoback  </span>            <span class="hljs-comment"></span>
  <span class="hljs-keyword">/bring  </span>               <span class="hljs-comment">--[ID]</span>
  <span class="hljs-keyword">/bringback  </span>           <span class="hljs-comment">--[ID]</span>
  <span class="hljs-keyword">/heal  </span>                <span class="hljs-comment">--[ID]</span>
  <span class="hljs-keyword">/revive  </span>              <span class="hljs-comment">--[ID]</span>
  <span class="hljs-keyword">/wipe  </span>                <span class="hljs-comment">--[IDENTIFIER]</span>
</code></pre>
<p class="has-line-data" data-line-start="71" data-line-end="73">--The REASON must be written between two " " or it won't work<br>  
<p class="has-line-data" data-line-start="71" data-line-end="73">--The EXPIRE of the ban is expressed in days<br>  
<p class="has-line-data" data-line-start="71" data-line-end="73">--The id Ban for the sban via command can be found in the webhooks<br>  
<h2 class="code-line" data-line-start=70 data-line-end=71><a id="Credits"></a>Credits</h2>
<p class="has-line-data" data-line-start="71" data-line-end="73">The publication of the script does not authorize its commercialization. if you have any advice or want to propose changes you can contact us via discord<br>  
<pre><code class="has-line-data" data-line-start="75" data-line-end="80" class="language-lua"></code>
  <span class="hljs-string">"Main Developer:"  </span> <span class="hljs-comment">MaXxaM#0511</span>
  <span class="hljs-string">"Supports:"       </span> <span class="hljs-comment">Loweri#9667</span>
  <span class="hljs-string">"Powered By"      </span> <span class="hljs-comment">fenixhub.dev</span>

</code></pre>
</body></html>
