"""The First Light profile of the launcher (ISS_GAME, default in this fork): its defaults reach
the game as ISS_* variables, Second Son keeps the core's. Each case runs in its own Python, since
the profile is chosen when infamous_run is imported."""
import json
import os
import subprocess
import sys
import tempfile
import unittest

from paths import ROOT

PROBE = r'''
import json, sys
sys.path.insert(0, sys.argv[1])
import infamous_run as r
s = dict(r.DEFAULT_SETTINGS)
env = r.build_env(s)
keys = ('ISS_GC_BUDGET_MB', 'ISS_BP07', 'ISS_STALE_READBACK', 'ISS_OCCLUSION_MODE', 'ISS_APP_NAME')
print(json.dumps({'first_light': r.FIRST_LIGHT, 'env': {k: env.get(k) for k in keys},
                  'config': r.config_path().parent.name, 'vsync': s['vsync'],
                  'serials': list(r.SHADER_CACHE_SERIALS)}))
'''


def profile(game):
    env = {k: v for k, v in os.environ.items() if not k.startswith(('ISS_', 'TLG_'))}
    if game is not None:
        env['ISS_GAME'] = game
    with tempfile.TemporaryDirectory() as config:
        env['APPDATA'] = env['XDG_CONFIG_HOME'] = config  # no player settings file
        out = subprocess.run([sys.executable, '-c', PROBE, str(ROOT / 'launcher')], env=env,
                             capture_output=True, text=True, check=True).stdout
    return json.loads(out.strip().splitlines()[-1])


class FirstLightProfileTest(unittest.TestCase):
    def test_first_light_is_the_default(self):
        p = profile(None)
        self.assertTrue(p['first_light'])
        self.assertEqual(p['env'], {'ISS_GC_BUDGET_MB': 'card', 'ISS_BP07': '1', 'ISS_STALE_READBACK': '0',
                                    'ISS_OCCLUSION_MODE': '2', 'ISS_APP_NAME': 'inFAMOUS First Light'})
        self.assertEqual(p['config'], 'infamous-firstlight-launcher')
        self.assertFalse(p['vsync'])
        self.assertEqual(p['serials'], ['CUSA00575'])

    def test_second_son_keeps_the_core_defaults(self):
        p = profile('secondson')
        self.assertFalse(p['first_light'])
        self.assertEqual(p['env'], {'ISS_GC_BUDGET_MB': '3500', 'ISS_BP07': None, 'ISS_STALE_READBACK': None,
                                    'ISS_OCCLUSION_MODE': None, 'ISS_APP_NAME': 'inFAMOUS Second Son'})
        self.assertEqual(p['config'], 'infamous-launcher')
        self.assertEqual(p['serials'], ['CUSA00223'])


if __name__ == '__main__':
    unittest.main()
