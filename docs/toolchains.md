<!-- Generated with Stardoc: http://skydoc.bazel.build -->

# Toolchains

Rules and helpers to create platform-specific toolchains and use them in module extensions.

<a id="binary_toolchain"></a>

## binary_toolchain

<pre>
binary_toolchain(<a href="#binary_toolchain-name">name</a>, <a href="#binary_toolchain-binary">binary</a>, <a href="#binary_toolchain-files">files</a>, <a href="#binary_toolchain-prefix">prefix</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="binary_toolchain-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="binary_toolchain-binary"></a>binary |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="binary_toolchain-files"></a>files |  -   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="binary_toolchain-prefix"></a>prefix |  -   | String | required |  |


<a id="platform_assets"></a>

## platform_assets

<pre>
platform_assets(<a href="#platform_assets-name">name</a>, <a href="#platform_assets-algo">algo</a>, <a href="#platform_assets-binary">binary</a>, <a href="#platform_assets-files">files</a>, <a href="#platform_assets-integrity">integrity</a>, <a href="#platform_assets-platform">platform</a>, <a href="#platform_assets-url">url</a>, <a href="#platform_assets-url_flag">url_flag</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="platform_assets-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="platform_assets-algo"></a>algo |  -   | String | optional |  `"384"`  |
| <a id="platform_assets-binary"></a>binary |  -   | String | optional |  `""`  |
| <a id="platform_assets-files"></a>files |  -   | List of strings | optional |  `[]`  |
| <a id="platform_assets-integrity"></a>integrity |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="platform_assets-platform"></a>platform |  -   | String | optional |  `""`  |
| <a id="platform_assets-url"></a>url |  -   | String | optional |  `""`  |
| <a id="platform_assets-url_flag"></a>url_flag |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |


<a id="assets_bundle"></a>

## assets_bundle

<pre>
assets_bundle(<a href="#assets_bundle-name">name</a>, <a href="#assets_bundle-out_file">out_file</a>, <a href="#assets_bundle-write_file">write_file</a>, <a href="#assets_bundle-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="assets_bundle-name"></a>name |  <p align="center"> - </p>   |  `"assets"` |
| <a id="assets_bundle-out_file"></a>out_file |  <p align="center"> - </p>   |  `None` |
| <a id="assets_bundle-write_file"></a>write_file |  <p align="center"> - </p>   |  `True` |
| <a id="assets_bundle-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="multi_platform_assets"></a>

## multi_platform_assets

<pre>
multi_platform_assets(<a href="#multi_platform_assets-name">name</a>, <a href="#multi_platform_assets-url">url</a>, <a href="#multi_platform_assets-platforms">platforms</a>, <a href="#multi_platform_assets-assets_file">assets_file</a>, <a href="#multi_platform_assets-darwin_ext">darwin_ext</a>, <a href="#multi_platform_assets-windows_ext">windows_ext</a>,
                      <a href="#multi_platform_assets-set_windows_binary_ext">set_windows_binary_ext</a>, <a href="#multi_platform_assets-linux_ext">linux_ext</a>, <a href="#multi_platform_assets-binary">binary</a>, <a href="#multi_platform_assets-prefix">prefix</a>, <a href="#multi_platform_assets-files">files</a>, <a href="#multi_platform_assets-platforms_map">platforms_map</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="multi_platform_assets-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="multi_platform_assets-url"></a>url |  <p align="center"> - </p>   |  none |
| <a id="multi_platform_assets-platforms"></a>platforms |  <p align="center"> - </p>   |  none |
| <a id="multi_platform_assets-assets_file"></a>assets_file |  <p align="center"> - </p>   |  `"assets.bzl"` |
| <a id="multi_platform_assets-darwin_ext"></a>darwin_ext |  <p align="center"> - </p>   |  `"tar.gz"` |
| <a id="multi_platform_assets-windows_ext"></a>windows_ext |  <p align="center"> - </p>   |  `"zip"` |
| <a id="multi_platform_assets-set_windows_binary_ext"></a>set_windows_binary_ext |  <p align="center"> - </p>   |  `True` |
| <a id="multi_platform_assets-linux_ext"></a>linux_ext |  <p align="center"> - </p>   |  `"tar.gz"` |
| <a id="multi_platform_assets-binary"></a>binary |  <p align="center"> - </p>   |  `None` |
| <a id="multi_platform_assets-prefix"></a>prefix |  <p align="center"> - </p>   |  `""` |
| <a id="multi_platform_assets-files"></a>files |  <p align="center"> - </p>   |  `[]` |
| <a id="multi_platform_assets-platforms_map"></a>platforms_map |  <p align="center"> - </p>   |  `{}` |


<a id="register_platform_toolchains"></a>

## register_platform_toolchains

<pre>
register_platform_toolchains(<a href="#register_platform_toolchains-name">name</a>, <a href="#register_platform_toolchains-assets">assets</a>, <a href="#register_platform_toolchains-toolchain_type">toolchain_type</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="register_platform_toolchains-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="register_platform_toolchains-assets"></a>assets |  <p align="center"> - </p>   |  none |
| <a id="register_platform_toolchains-toolchain_type"></a>toolchain_type |  <p align="center"> - </p>   |  none |


<a id="resolved_toolchain_impl"></a>

## resolved_toolchain_impl

<pre>
resolved_toolchain_impl(<a href="#resolved_toolchain_impl-toolchain">toolchain</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="resolved_toolchain_impl-toolchain"></a>toolchain |  <p align="center"> - </p>   |  none |


<a id="platform_toolchain"></a>

## platform_toolchain

<pre>
platform_toolchain(<a href="#platform_toolchain-name">name</a>, <a href="#platform_toolchain-binary">binary</a>, <a href="#platform_toolchain-files">files</a>, <a href="#platform_toolchain-integrity">integrity</a>, <a href="#platform_toolchain-prefix">prefix</a>, <a href="#platform_toolchain-repo_mapping">repo_mapping</a>, <a href="#platform_toolchain-url">url</a>)
</pre>

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="platform_toolchain-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="platform_toolchain-binary"></a>binary |  -   | String | optional |  `""`  |
| <a id="platform_toolchain-files"></a>files |  -   | List of strings | optional |  `[]`  |
| <a id="platform_toolchain-integrity"></a>integrity |  -   | String | optional |  `""`  |
| <a id="platform_toolchain-prefix"></a>prefix |  -   | String | optional |  `""`  |
| <a id="platform_toolchain-repo_mapping"></a>repo_mapping |  In `WORKSPACE` context only: a dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.<br><br>For example, an entry `"@foo": "@bar"` declares that, for any time this repository depends on `@foo` (such as a dependency on `@foo//some:target`, it should actually resolve that dependency within globally-declared `@bar` (`@bar//some:target`).<br><br>This attribute is _not_ supported in `MODULE.bazel` context (when invoking a repository rule inside a module extension's implementation function).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  |
| <a id="platform_toolchain-url"></a>url |  -   | String | optional |  `""`  |


<a id="platform_toolchains"></a>

## platform_toolchains

<pre>
platform_toolchains(<a href="#platform_toolchains-name">name</a>, <a href="#platform_toolchains-build_file">build_file</a>, <a href="#platform_toolchains-repo_mapping">repo_mapping</a>)
</pre>

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="platform_toolchains-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="platform_toolchains-build_file"></a>build_file |  -   | String | required |  |
| <a id="platform_toolchains-repo_mapping"></a>repo_mapping |  In `WORKSPACE` context only: a dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.<br><br>For example, an entry `"@foo": "@bar"` declares that, for any time this repository depends on `@foo` (such as a dependency on `@foo//some:target`, it should actually resolve that dependency within globally-declared `@bar` (`@bar//some:target`).<br><br>This attribute is _not_ supported in `MODULE.bazel` context (when invoking a repository rule inside a module extension's implementation function).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  |


