# Schrödinger's UGens

## Installation

Move the folder to your SuperCollider extensions folder. You can find it by evaluating

```supercollider
Platform.userExtensionDir
```

in SuperCollider. To evaluate code in SuperCollder, put your cursor on the line of code and press `Cmd+Enter`
(macOS) or `Ctrl+Enter`.  Alternatively, you may install the extensions system-wide by copying to

```supercollider
Platform.systemExtensionDir
```

The folder might not exist, so you may need to create it yourself. You can do this in your operating system's file
explorer or from within SuperCollider by evaluating:

```supercollider
File.mkdir(Platform.userExtensionDir)
```

On some operating systems, these directories may be hard to find because they're in hidden folders.  You can open
the user app support directory (where the Extensions folder is) with the menu item
"File->Open user support directory". On macOS, you can open a finder window and press `Cmd+Shift+G` and enter the
name of the directory.

