# openstack cloud options

<ul>
<li>
  <b><u>openstack.enable</u></b><br>
  <b>type</b>: boolean<br>
  <b>default</b>: false<br>
  <b>example</b>: true<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/provider.nix">module/provider.nix</a><br>
  <b>description</b>: Whether to enable openstack provider
See https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs for documentation.
.<br>
</li>
<li>
  <b><u>openstack.export.nix</u></b><br>
  <b>type</b>: null or string<br>
  <b>default</b>: null<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/export.nix">module/export.nix</a><br>
  <b>description</b>: Export openstack information as nix file.
Useful when if you want to import run a NixOs
script after the terraform.
<br>
</li>
<li>
  <b><u>openstack.provider.authUrl</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;${ admin }&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/provider.nix">module/provider.nix</a><br>
  <b>description</b>: The identity authentication URL. If omitted, the
OS_AUTH_URL environment variable is used.
<br>
</li>
<li>
  <b><u>openstack.provider.cloud</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;garr-pa1&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/provider.nix">module/provider.nix</a><br>
  <b>description</b>: An entry in a clouds.yaml file. See the OpenStack
documentation for more information about.
Required if authUrl is not specified.
<br>
</li>
<li>
  <b><u>openstack.provider.credId</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;${ admin }&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/provider.nix">module/provider.nix</a><br>
  <b>description</b>: The ID of an application credential to authenticate with.
A credSecret has to be set along with this parameter.
<br>
</li>
<li>
  <b><u>openstack.provider.credSecret</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;${ pwd }&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/provider.nix">module/provider.nix</a><br>
  <b>description</b>: The secret of an application credential to authenticate
with. Required by credId.
<br>
</li>
<li>
  <b><u>openstack.provider.region</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;${ admin }&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/provider.nix">module/provider.nix</a><br>
  <b>description</b>: The region of the OpenStack cloud to use.
<br>
</li>
<li>
  <b><u>openstack.server</u></b><br>
  <b>type</b>: attribute set of submodules<br>
  <b>default</b>: {}<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: servers deployed to openstack.
<br>
</li>
<li>
  <b><u>openstack.server.&lt;name&gt;.enable</u></b><br>
  <b>type</b>: boolean<br>
  <b>default</b>: false<br>
  <b>example</b>: true<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: Whether to enable Deploy server
.<br>
</li>
<li>
  <b><u>openstack.server.&lt;name&gt;.extraConfig</u></b><br>
  <b>type</b>: attribute set<br>
  <b>default</b>: {}<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: parameter of the openstack_server not covered yet.
<br>
</li>
<li>
  <b><u>openstack.server.&lt;name&gt;.flavor</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;m2.medium&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: Flavor types.
<br>
</li>
<li>
  <b><u>openstack.server.&lt;name&gt;.floatingIpPool</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;floating-ip&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: A pool from the floating ip will be withdrawed.
<br>
</li>
<li>
  <b><u>openstack.server.&lt;name&gt;.image</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;ubuntu-18.04&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: image to spawn on the server
<br>
</li>
<li>
  <b><u>openstack.server.&lt;name&gt;.name</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: &#34;‹name›&#34;<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: Name of the server to deploy.
<br>
</li>
<li>
  <b><u>openstack.server.&lt;name&gt;.networkId</u></b><br>
  <b>type</b>: string<br>
  <b>default</b>: null<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: A network id
<br>
</li>
<li>
  <b><u>openstack.server.&lt;name&gt;.networks</u></b><br>
  <b>type</b>: list of attribute sets<br>
  <b>default</b>: [{&#34;port&#34;:&#34;${openstack_networking_port_v2.test.id}&#34;}]<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: An array of one or more networks to attach to the instance.
<br>
</li>
<li>
  <b><u>openstack.server.&lt;name&gt;.provisioners</u></b><br>
  <b>type</b>: list of attribute sets<br>
  <b>default</b>: []<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: provision steps.
remote-exec...
<br>
</li>
<li>
  <b><u>openstack.server.&lt;name&gt;.securityGroups</u></b><br>
  <b>type</b>: list of strings<br>
  <b>default</b>: null<br>
  <b>example</b>: null<br>
  <b>defined</b>: <a href="https://github.com/heph2/terranix-openstack/tree/main/modulemodule/server.nix">module/server.nix</a><br>
  <b>description</b>: A list of security groups ids.
<br>
</li>
</ul>
