## will create a list of packages as a text file that can be fed into an install command
```
sudo pacman -Qqe > packages.txt
```
```
sudo pacman -S --needed - < packages.txt
```

```
sudo apt list --installed > packages.txt
```

```
sudo apt install - < packages.txt
```
