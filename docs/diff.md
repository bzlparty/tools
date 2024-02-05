<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Create and Update Patches

<a id="diff"></a>

## diff

<pre>
diff(<a href="#diff-name">name</a>, <a href="#diff-source">source</a>, <a href="#diff-target">target</a>, <a href="#diff-input">input</a>)
</pre>

Create a patch file from `source` and `target` files.

&gt; [!NOTE]
&gt; This is a simple rule that uses the `diff` command from the host system.
&gt; There is no toolchain that uses a platform specific tool.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="diff-name"></a>name |  A unique name for the target.   |  none |
| <a id="diff-source"></a>source |  Source file to create the patch for.   |  none |
| <a id="diff-target"></a>target |  Target file to compare the <code>source</code> to.   |  none |
| <a id="diff-input"></a>input |  Input patch file, optional. Defaults to a file named like the rule with the <code>patch</code> extension, e.g. <code>module_bazel.patch</code>.   |  <code>None</code> |


<a id="update_patches"></a>

## update_patches

<pre>
update_patches(<a href="#update_patches-name">name</a>, <a href="#update_patches-kwargs">kwargs</a>)
</pre>

Macro to update all patch files in a package.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="update_patches-name"></a>name |  A unique name for the target.   |  <code>"update_patches"</code> |
| <a id="update_patches-kwargs"></a>kwargs |  All other arguments from [<code>write_source_files</code>](https://github.com/aspect-build/bazel-lib/blob/main/docs/write_source_files.md#write_source_files)   |  none |


