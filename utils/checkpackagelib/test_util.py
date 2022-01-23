def check_file(check_function, filename, string):
    obj = check_function(filename, 'url')
    result = []
    result.append(obj.before())
    for i, line in enumerate(string.splitlines(True)):
        result.append(obj.check_line(i + 1, line))
    result.append(obj.after())
    return [r for r in result if r is not None]
