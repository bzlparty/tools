<!-- Generated with Stardoc: http://skydoc.bazel.build -->


Workspace Rules

Some rules that are used for maintaining other bzlparty projects.



<a id="create_module_bazel"></a>

## create_module_bazel

<pre>
create_module_bazel(<a href="#create_module_bazel-name">name</a>, <a href="#create_module_bazel-module_file">module_file</a>, <a href="#create_module_bazel-out">out</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="create_module_bazel-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="create_module_bazel-module_file"></a>module_file |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>//:MODULE.bazel</code> |
| <a id="create_module_bazel-out"></a>out |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |


<a id="formatter"></a>

## formatter

<pre>
formatter(<a href="#formatter-name">name</a>, <a href="#formatter-config">config</a>, <a href="#formatter-exclude">exclude</a>, <a href="#formatter-mode">mode</a>, <a href="#formatter-tools">tools</a>, <a href="#formatter-workspace">workspace</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="formatter-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="formatter-config"></a>config |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="formatter-exclude"></a>exclude |  -   | List of strings | optional | <code>[]</code> |
| <a id="formatter-mode"></a>mode |  -   | String | optional | <code>"check"</code> |
| <a id="formatter-tools"></a>tools |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: Label -> String</a> | required |  |
| <a id="formatter-workspace"></a>workspace |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>@@//:MODULE.bazel</code> |


<a id="formatter_test"></a>

## formatter_test

<pre>
formatter_test(<a href="#formatter_test-name">name</a>, <a href="#formatter_test-config">config</a>, <a href="#formatter_test-exclude">exclude</a>, <a href="#formatter_test-mode">mode</a>, <a href="#formatter_test-tools">tools</a>, <a href="#formatter_test-workspace">workspace</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="formatter_test-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="formatter_test-config"></a>config |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="formatter_test-exclude"></a>exclude |  -   | List of strings | optional | <code>[]</code> |
| <a id="formatter_test-mode"></a>mode |  -   | String | optional | <code>"check"</code> |
| <a id="formatter_test-tools"></a>tools |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: Label -> String</a> | required |  |
| <a id="formatter_test-workspace"></a>workspace |  -   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>@@//:MODULE.bazel</code> |


<a id="git_archive"></a>

## git_archive

<pre>
git_archive(<a href="#git_archive-name">name</a>, <a href="#git_archive-package_name">package_name</a>, <a href="#git_archive-virtual_files">virtual_files</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="git_archive-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="git_archive-package_name"></a>package_name |  -   | String | required |  |
| <a id="git_archive-virtual_files"></a>virtual_files |  -   | <a href="https://bazel.build/rules/lib/dict">Dictionary: Label -> String</a> | optional | <code>{}</code> |


