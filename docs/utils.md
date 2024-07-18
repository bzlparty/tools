<!-- Generated with Stardoc: http://skydoc.bazel.build -->

# Utils

<a id="declare_launcher_file"></a>

## declare_launcher_file

<pre>
declare_launcher_file(<a href="#declare_launcher_file-ctx">ctx</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="declare_launcher_file-ctx"></a>ctx |  <p align="center"> - </p>   |  none |


<a id="get_binary_from_toolchain"></a>

## get_binary_from_toolchain

<pre>
get_binary_from_toolchain(<a href="#get_binary_from_toolchain-ctx">ctx</a>, <a href="#get_binary_from_toolchain-toolchain">toolchain</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="get_binary_from_toolchain-ctx"></a>ctx |  <p align="center"> - </p>   |  none |
| <a id="get_binary_from_toolchain-toolchain"></a>toolchain |  <p align="center"> - </p>   |  none |


<a id="platform_from_constraints"></a>

## platform_from_constraints

<pre>
platform_from_constraints(<a href="#platform_from_constraints-constraints">constraints</a>)
</pre>

Get platform from constraints

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="platform_from_constraints-constraints"></a>constraints |  list of platform constraints, e.g. <code>["@platforms//os:linux", "@platforms//cpu:x86_64"]</code>.   |  none |

**RETURNS**

platform string, e.g. `linux_amd64`.


