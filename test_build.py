import os

def test_html_exists_and_valid():
    # Check if file exists
    assert os.path.exists('index.html'), "Build failed: index.html is missing!"
    
    # Check if the content is correct
    with open('index.html', 'r') as file:
        content = file.read()
        assert "DevOps Pipeline" in content, "QA failed: Incorrect content in HTML."
        
    print("QA Passed: HTML file is valid and ready for deployment.")

if __name__ == "__main__":
    test_html_exists_and_valid()
