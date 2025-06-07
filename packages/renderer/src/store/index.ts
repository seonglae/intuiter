export type State = {
  loading: boolean
  customAppPaths: string[]
}

export const strict = false

export const state = (): State => ({
  loading: false,
  customAppPaths: Array(10).fill('')
})

export const mutations = {
  setLoading(state: State, value: boolean): void  {
    /**
     * @summary - set global loading state
     */
    state.loading = value
  }
  ,
  setCustomAppPath(state: State, payload: { index: number; value: string }): void {
    state.customAppPaths[payload.index] = payload.value
  }
}
