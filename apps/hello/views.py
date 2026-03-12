from django.shortcuts import render


def hello_world(request):
    """
    Vue simple qui affiche "Hello world!"
    """
    return render(request, 'hello/index.html')
