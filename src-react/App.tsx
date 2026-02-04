import { useState, useEffect, useRef } from 'react'
import { invoke } from '@tauri-apps/api/core'
import { open } from '@tauri-apps/plugin-shell'
import { exit } from '@tauri-apps/plugin-process'
import DancingButton from 'dancing-button'

const tabs = ['Home', 'Option', 'Shortcut', 'Extension', 'Custom', 'Document']

export default function App() {
  const [activeTab, setActiveTab] = useState(0)
  const [loading, setLoading] = useState(false)
  const buttonRef = useRef<SVGSVGElement>(null)

  useEffect(() => {
    if (buttonRef.current) {
      new DancingButton(buttonRef.current)
    }
  }, [])

  async function handleStart() {
    setLoading(true)
    try {
      await invoke('spawn_input')
    } catch (e) {
      console.error(e)
    }
    setLoading(false)
  }

  async function handleGithub() {
    await open('https://github.com/seonglae/intuiter')
  }

  async function handleExit() {
    await exit(0)
  }

  return (
    <div className="h-full flex flex-col bg-[#121314] text-white rounded-3xl overflow-hidden">
      {/* Header */}
      <header className="flex items-center px-4 py-3 bg-[#1a1b1c] rounded-t-xl" style={{ WebkitAppRegion: 'drag' } as React.CSSProperties}>
        <h1 className="text-lg uppercase tracking-wide mr-4">
          <span>Intuit </span>
          <span className="font-light">Manager</span>
        </h1>

        <nav className="flex-1 flex justify-center gap-1" style={{ WebkitAppRegion: 'no-drag' } as React.CSSProperties}>
          {tabs.map((tab, i) => (
            <button
              key={tab}
              onClick={() => setActiveTab(i)}
              className={`px-4 py-2 text-sm transition-colors ${
                activeTab === i
                  ? 'text-white border-b-2 border-white'
                  : 'text-zinc-400 hover:text-white'
              }`}
            >
              {tab}
            </button>
          ))}
        </nav>

        <div className="flex gap-2" style={{ WebkitAppRegion: 'no-drag' } as React.CSSProperties}>
          <button onClick={handleGithub} className="px-3 py-1 text-sm hover:text-zinc-300">
            Github
          </button>
          <button onClick={handleExit} className="px-3 py-1 text-sm hover:text-zinc-300">
            Exit
          </button>
        </div>
      </header>

      {/* Content */}
      <main className="flex-1 flex items-center justify-center">
        {activeTab === 0 && (
          <div className="text-center">
            <h1 className="text-4xl font-bold mb-6">Intuiter</h1>
            <svg ref={buttonRef} onClick={handleStart} className="w-[200px] h-[60px] cursor-pointer mx-auto" />
          </div>
        )}

        {activeTab === 1 && (
          <div className="text-center space-y-4">
            <label className="flex items-center justify-center gap-3">
              <input type="checkbox" className="w-4 h-4" />
              <span>Launch at startup</span>
            </label>
            <label className="flex items-center justify-center gap-3">
              <input type="checkbox" className="w-4 h-4" />
              <span>Show in menu bar</span>
            </label>
            <label className="flex items-center justify-center gap-3">
              <input type="checkbox" className="w-4 h-4" />
              <span>Enable notifications</span>
            </label>
          </div>
        )}

        {activeTab === 2 && (
          <div className="text-center">
            <table className="mx-auto text-left">
              <thead>
                <tr className="border-b border-zinc-700">
                  <th className="px-4 py-2">Shortcut</th>
                  <th className="px-4 py-2">Action</th>
                </tr>
              </thead>
              <tbody className="text-zinc-300">
                <tr><td className="px-4 py-1">Caps + H</td><td className="px-4 py-1">Left Arrow</td></tr>
                <tr><td className="px-4 py-1">Caps + J</td><td className="px-4 py-1">Down Arrow</td></tr>
                <tr><td className="px-4 py-1">Caps + K</td><td className="px-4 py-1">Up Arrow</td></tr>
                <tr><td className="px-4 py-1">Caps + L</td><td className="px-4 py-1">Right Arrow</td></tr>
                <tr><td className="px-4 py-1">Caps + U</td><td className="px-4 py-1">Mouse Left</td></tr>
                <tr><td className="px-4 py-1">Caps + I</td><td className="px-4 py-1">Mouse Down</td></tr>
                <tr><td className="px-4 py-1">Caps + O</td><td className="px-4 py-1">Mouse Up</td></tr>
                <tr><td className="px-4 py-1">Caps + P</td><td className="px-4 py-1">Mouse Right</td></tr>
              </tbody>
            </table>
          </div>
        )}

        {activeTab === 3 && (
          <div className="text-center space-y-2">
            <div className="p-3 bg-zinc-800 rounded">
              <div className="font-medium">Text Mode</div>
              <div className="text-sm text-zinc-400">Caps + T to toggle</div>
            </div>
            <div className="p-3 bg-zinc-800 rounded">
              <div className="font-medium">Mouse Mode</div>
              <div className="text-sm text-zinc-400">Caps + M to toggle</div>
            </div>
            <div className="p-3 bg-zinc-800 rounded">
              <div className="font-medium">Window Mode</div>
              <div className="text-sm text-zinc-400">Caps + W to toggle</div>
            </div>
          </div>
        )}

        {activeTab === 4 && (
          <div className="text-center space-y-3 w-80">
            {['1','2','3','4','5','6','7','8','9','0'].map((d, i) => (
              <div key={d} className="flex items-center gap-2">
                <label className="w-16 text-right text-zinc-400">Cmd+{d}</label>
                <input type="text" className="flex-1 px-3 py-1 bg-zinc-800 border border-zinc-700 rounded text-sm" />
              </div>
            ))}
            <button className="mt-4 px-6 py-2 bg-blue-600 hover:bg-blue-500 rounded">Save</button>
          </div>
        )}

        {activeTab === 5 && (
          <iframe
            src="https://intuiter.vercel.app/en/usages/text.html"
            className="w-full h-full border-none"
          />
        )}
      </main>

      {/* Loading overlay */}
      {loading && (
        <div className="absolute inset-0 flex items-center justify-center bg-black/50">
          <div className="w-12 h-12 border-4 border-white border-t-transparent rounded-full animate-spin" />
        </div>
      )}
    </div>
  )
}
