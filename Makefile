.PHONY: compile cuda korte setup

compile:
	mkdir -p minitorch/cuda_kernels
	nvcc -o minitorch/cuda_kernels/combine.so --shared src/combine.cu -Xcompiler -fPIC

cuda:
	apt-get remove --purge libcublas* cuda-* nvidia-* -y --allow-change-held-packages
	apt-get autoremove -y
	apt-get clean
	rm -rf /usr/local/cuda*
	apt-get install -y cuda-toolkit-12-4
	ls /usr/local | grep cuda

korte:
	git config --global user.email "kortemaki@gmail.com"
	git config --global user.name "Korte Maki"

setup:
	apt-get update
	apt-get upgrade
	apt-get install emacs -y
	python -m pip install -r requirements.txt
	python -m pip install -r requirements.extra.txt
	python -m pip install -Ue .
	python -c "import minitorch; print('Success: minitorch is installed correctly');" 2>/dev/null || echo "Error: Failed to import minitorch. Please check your installation."
