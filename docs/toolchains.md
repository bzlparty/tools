<!-- Generated with Stardoc: http://skydoc.bazel.build -->

# Toolchains

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
| <a id="binary_toolchain-files"></a>files |  -   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |
| <a id="binary_toolchain-prefix"></a>prefix |  -   | String | required |  |


<a id="platform_toolchain"></a>

## platform_toolchain

<pre>
platform_toolchain(<a href="#platform_toolchain-name">name</a>, <a href="#platform_toolchain-binary">binary</a>, <a href="#platform_toolchain-integrity">integrity</a>, <a href="#platform_toolchain-prefix">prefix</a>, <a href="#platform_toolchain-repo_mapping">repo_mapping</a>, <a href="#platform_toolchain-url">url</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="platform_toolchain-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="platform_toolchain-binary"></a>binary |  -   | String | optional | <code>""</code> |
| <a id="platform_toolchain-integrity"></a>integrity |  -   | String | optional | <code>""</code> |
| <a id="platform_toolchain-prefix"></a>prefix |  -   | String | optional | <code>""</code> |
| <a id="platform_toolchain-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |
| <a id="platform_toolchain-url"></a>url |  -   | String | optional | <code>""</code> |


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
| <a id="platform_toolchains-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |


<a id="BinaryToolchainInfo"></a>

## BinaryToolchainInfo

<pre>
BinaryToolchainInfo(<a href="#BinaryToolchainInfo-binary">binary</a>, <a href="#BinaryToolchainInfo-files">files</a>)
</pre>

Binary Toolchain Provider

**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="BinaryToolchainInfo-binary"></a>binary |  Path to binary    |
| <a id="BinaryToolchainInfo-files"></a>files |  Paths to library files    |


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


