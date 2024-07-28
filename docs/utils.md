<!-- Generated with Stardoc: http://skydoc.bazel.build -->



# Rules



<a id="dcomment"></a>

## dcomment

<pre>
dcomment(<a href="#dcomment-name">name</a>, <a href="#dcomment-defines">defines</a>, <a href="#dcomment-out">out</a>, <a href="#dcomment-src">src</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="dcomment-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="dcomment-defines"></a>defines |  -   | String | optional | <code>""</code> |
| <a id="dcomment-out"></a>out |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="dcomment-src"></a>src |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |


<a id="formatter"></a>

## formatter

<pre>
formatter(<a href="#formatter-name">name</a>, <a href="#formatter-config">config</a>, <a href="#formatter-exclude">exclude</a>, <a href="#formatter-jobs">jobs</a>, <a href="#formatter-mode">mode</a>, <a href="#formatter-tools">tools</a>, <a href="#formatter-workspace">workspace</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="formatter-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="formatter-config"></a>config |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="formatter-exclude"></a>exclude |  -   | List of strings | optional | <code>[]</code> |
| <a id="formatter-jobs"></a>jobs |  -   | Integer | optional | <code>0</code> |
| <a id="formatter-mode"></a>mode |  -   | String | optional | <code>"check"</code> |
| <a id="formatter-tools"></a>tools |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: Label -> String</a> | required |  |
| <a id="formatter-workspace"></a>workspace |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>@@//:MODULE.bazel</code> |


<a id="formatter_test"></a>

## formatter_test

<pre>
formatter_test(<a href="#formatter_test-name">name</a>, <a href="#formatter_test-config">config</a>, <a href="#formatter_test-exclude">exclude</a>, <a href="#formatter_test-jobs">jobs</a>, <a href="#formatter_test-mode">mode</a>, <a href="#formatter_test-tools">tools</a>, <a href="#formatter_test-workspace">workspace</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="formatter_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="formatter_test-config"></a>config |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="formatter_test-exclude"></a>exclude |  -   | List of strings | optional | <code>[]</code> |
| <a id="formatter_test-jobs"></a>jobs |  -   | Integer | optional | <code>0</code> |
| <a id="formatter_test-mode"></a>mode |  -   | String | optional | <code>"check"</code> |
| <a id="formatter_test-tools"></a>tools |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: Label -> String</a> | required |  |
| <a id="formatter_test-workspace"></a>workspace |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>@@//:MODULE.bazel</code> |


<a id="git_archive"></a>

## git_archive

<pre>
git_archive(<a href="#git_archive-name">name</a>, <a href="#git_archive-commit">commit</a>, <a href="#git_archive-dir">dir</a>, <a href="#git_archive-package_name">package_name</a>, <a href="#git_archive-virtual_files">virtual_files</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="git_archive-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="git_archive-commit"></a>commit |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>@bzlparty_tools//lib:release_tag</code> |
| <a id="git_archive-dir"></a>dir |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>@bzlparty_tools//lib:release_dir</code> |
| <a id="git_archive-package_name"></a>package_name |  -   | String | required |  |
| <a id="git_archive-virtual_files"></a>virtual_files |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: Label -> String</a> | optional | <code>{}</code> |


<a id="release_arg"></a>

## release_arg

<pre>
release_arg(<a href="#release_arg-name">name</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="release_arg-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |


<a id="sha"></a>

## sha

<pre>
sha(<a href="#sha-name">name</a>, <a href="#sha-algo">algo</a>, <a href="#sha-out">out</a>, <a href="#sha-src">src</a>, <a href="#sha-url">url</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="sha-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="sha-algo"></a>algo |  -   | String | optional | <code>"384"</code> |
| <a id="sha-out"></a>out |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  |
| <a id="sha-src"></a>src |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="sha-url"></a>url |  -   | String | optional | <code>""</code> |


<a id="shellspec_test"></a>

## shellspec_test

<pre>
shellspec_test(<a href="#shellspec_test-name">name</a>, <a href="#shellspec_test-config">config</a>, <a href="#shellspec_test-spec">spec</a>, <a href="#shellspec_test-srcs">srcs</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="shellspec_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="shellspec_test-config"></a>config |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="shellspec_test-spec"></a>spec |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |
| <a id="shellspec_test-srcs"></a>srcs |  -   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional | <code>[]</code> |


<a id="ReleaseInfo"></a>

## ReleaseInfo

<pre>
ReleaseInfo(<a href="#ReleaseInfo-value">value</a>)
</pre>



**FIELDS**


| Name  | Description |
| :------------- | :------------- |
| <a id="ReleaseInfo-value"></a>value |  (Undocumented)    |


<a id="versioned_module_bazel"></a>

## versioned_module_bazel

<pre>
versioned_module_bazel(<a href="#versioned_module_bazel-name">name</a>, <a href="#versioned_module_bazel-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="versioned_module_bazel-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="versioned_module_bazel-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


