from RPA.Assistant.library import *
from robot.api.deco import keyword, not_keyword, library
import asyncio

@keyword('Captcha Input Required')
def captcha_input_required():
    assistant = Assistant()
    assistant.add_heading("CAPTCHA Input Required")
    assistant.add_loading_spinner("Progress", 32, 32, 2, "primary")
    assistant.add_text("This test suite does not currently support CAPTCHA input or bypass.")
    assistant.add_text("Please manually complete the prompt.")
    assistant.add_text("This window will automatically close when the test is complete.")
    assistant.add_submit_buttons('Close')
    assistant.run_dialog(title="Notification")

# Manual testing
if __name__ == '__main__':
    captcha_input_required()